# Fanotify 
W ramach researchu napotkałem kilka projektów które mają na celu właśnie monitorowanie operacji IO na systemach z rodziny Linux. Jednym z tych projektów (istnieje jako narzędzie cli). Problem z tym rozwiązaniem polegał na tym, ze dokumentacja tego jest bardzo szczątkowa. W duzej mirze musiałem posilać się bezpośrednio source codem albo jedyną znaną implementacją tego rozwiązania - `fatrace`.
## Co udało mi się ustalić 
Metadane w fanotify przechowywane są w takiej strukturze danych jak przedstawiono ponizej.
```C
struct fanotify_event_metadata {
               __u32 event_len;
               __u8 vers;
               __u8 reserved;
               __u16 metadata_len;
               __aligned_u64 mask;
               __s32 fd;
               __s32 pid;
           };
```
Pierwsze trzy zmienne ustalają kolejno :
- długość bufora w którym przechowywana powinna być pełna informacja na temat wydarzenia,
- jezeli długość eventu przekracza długość bufora, to wtedy opisywana jest w drugiej zmiennej wielkość całości w ilości buforów o długości 256 znaków,
- dodatkowe dane które są związane z medium przesyłu, nie posiadają zadnej informacji o tym co de facto zawiera w sobie event,

Ostatnie trzy zmienne są tak nazwane, ze mozna się domyśleć ich przeznaczenia, z wyjątkiem `mask` która jest maską zdefiniowanych, w odpowiednich headerach rodzajów wydarzeń.


Wazną obserwacją w moim mniemaniu jest to, w jaki sposób mozna uzyskać siezkę do pliku na którym jest wykonywana operacja :
```C
ssize_t len = readlink(printbuf, pathname, sizeof(pathname));
```
`event len` pozwala na wyczytanie linka o długości ściezki absolutnej pliku z bufora przechowującego wydarzenia.

To zachowanie (nigdzie nie opisane) sprawia, ze mozna na spokojnie stwierdzić, ze rodzaj komunikacji między programem, a modułem serwującym dane to kolejka point-to-point.

To rozwiązanie nie oferuje out-of-the-box sprawdzenia w uid ownera procesu ale w `/proc` mozna to łatwo wyczytać jeśli ma się `file descriptor` :
```
/proc/<PID>/status-----------------------------------------...
Name: teams
Umask: 0077
Tgid: 2592
Ngid: 0
Pid: 2592
PPid: 2290
TracerPid: 0
Uid: 1000 1000 1000 1000
Gid: 1000 1000 1000 1000
FDSize: 256
...
```
Prawdopodbnie z tego punktu odczytałbym dane o ownerze poprzez mapowanie z :
```C
struct passwd *getpwuid(uid_t uid);
```
### Wydajność
Warunki testowe: 
- Linux 5.15.0-41-generic #44~20.04.1-Ubuntu
- Monitor z wersjo o końcówce hashu commita `6c7b05f`
- Narzędzie htop na próbie 2000 odczytów.

| Num. of processes | highest CPU usage [%] | avg CPU usage [%] |
|-------------------|-----------------------|-------------------|
| 10                | 3.3                   | 0.7               |
| 20                | 4.4                   | 2.6               |
| 40                | 6.5                   | 3.3               |
| 60                | 7.1                   | 2.6               |
| 100               | 9.8                   | 5.2               |
| 200               | 18.4                  | 13.2              |
| 300               | 26.7                  | 15.6              |


## Samba i NFS
Niestety w którymkolwiek z tych nie dokonałem postępów w researchu ze względu na skupienie się na tym co opisałem wyzej.

## Źródła
fnotify

https://manpages.ubuntu.com/manpages/focal/en/man7/fanotify.7.html
https://manpages.ubuntu.com/manpages/focal/en/man2/fanotify_init.2.html
https://manpages.ubuntu.com/manpages/focal/en/man2/fanotify_mark.2.html
https://manpages.ubuntu.com/manpages/focal/en/man7/inotify.7.html

Nie do końca zrodło ale jest tu duzo dobrych informacji:

https://support.sophos.com/support/s/article/KB-000034610?language=en_US

fatrace oraz mój szczątkowy fork:

https://github.com/martinpitt/fatrace

https://github.com/legeof008/fatrace

