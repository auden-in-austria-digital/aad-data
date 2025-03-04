## `input_img_id.csv` Analysis Report
### Missing Values Summary (`df.isnull().sum()`)
```
img               0
lrx               0
lry               0
width             0
height            0
type              0
ed                0
doc               0
title             0
author            0
author-uri        0
notBefore-iso     0
notAfter-iso      0
place             0
place-uri         0
repository        0
repository-uri    0
collection        0
idno              0
dtype: int64
```
### DataFrame Info (`df.info()`)
```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 254 entries, 0 to 253
Data columns (total 19 columns):
 #   Column          Non-Null Count  Dtype 
---  ------          --------------  ----- 
 0   img             254 non-null    int64 
 1   lrx             254 non-null    int64 
 2   lry             254 non-null    int64 
 3   width           254 non-null    int64 
 4   height          254 non-null    int64 
 5   type            254 non-null    object
 6   ed              254 non-null    object
 7   doc             254 non-null    object
 8   title           254 non-null    object
 9   author          254 non-null    object
 10  author-uri      254 non-null    object
 11  notBefore-iso   254 non-null    object
 12  notAfter-iso    254 non-null    object
 13  place           254 non-null    object
 14  place-uri       254 non-null    object
 15  repository      254 non-null    object
 16  repository-uri  254 non-null    object
 17  collection      254 non-null    object
 18  idno            254 non-null    object
dtypes: int64(5), object(14)
memory usage: 37.8+ KB

```
### Cleaned Document Data
```
                     author                                                                                             title          place
doc                                                                                                                                         
0001           Auden, W. H.                          Autograph Letter Signed W. H. Auden to Hugo Kurka 1960-07-25--1969-07-25   Kirchstetten
0002           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1964-09-08   Kirchstetten
0003           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1965-05-24   Kirchstetten
0004           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1964-10-07   Kirchstetten
0005           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1967-05-09   Kirchstetten
0006           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1967-06-05   Kirchstetten
0007           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1965-07-28   Kirchstetten
0008           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1965-04-16         Berlin
0009           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1966-06-29   Kirchstetten
0010           Auden, W. H.                                   Autograph Letter Signed W. H. Auden to Christa Kurka 1969-08-27   Kirchstetten
0011           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1965-06-27   Kirchstetten
0012           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1964-11-08         Berlin
0013           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1969-08-20   Kirchstetten
0014           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1964-12-08         Berlin
0015           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1964-06-25   Kirchstetten
0016           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1968-08-26   Kirchstetten
0017           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1965-08-16   Kirchstetten
0018           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1964-06-19   Kirchstetten
0019           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1966-05-04   Kirchstetten
0020           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1965-08-04   Kirchstetten
0021           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1964-09-16   Kirchstetten
0022           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1964-09-28   Kirchstetten
0023           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1966-05-20   Kirchstetten
0024           Auden, W. H.                                   Autograph Letter Signed W. H. Auden to Christa Kurka 1964-11-23         Berlin
0025           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1964-07-08   Kirchstetten
0026           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1966-08-16   Kirchstetten
0027           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1964-08-21   Kirchstetten
0028           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1964-11-01         Berlin
0029           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1964-07-12   Kirchstetten
0030           Auden, W. H.                          Autograph Letter Signed W. H. Auden to Hugo Kurka 1960-08-29--1968-07-29   Kirchstetten
0031           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1965-09-23   Kirchstetten
0032           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1964-08-18   Kirchstetten
0033           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1966-01-27  New York City
0034           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1967-03-28  New York City
0035           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1965-12-07  New York City
0036           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1965-11-11  New York City
0037           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1964-11-16         Berlin
0038           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1966-11-07  New York City
0039           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1966-11-26  New York City
0040           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1966-11-14  New York City
0041           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1967-04-05  New York City
0042           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1966-11-09  New York City
0043           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1964-06-10   Kirchstetten
0044           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1965-08-30   Kirchstetten
0045           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1966-03-01  New York City
0046           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1970-03-27  New York City
0047           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1966-09-14   Kirchstetten
0048           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1967-12-24  New York City
0049           Auden, W. H.                                          Typed Letter Signed W. H. Auden to Hugo Kurka 1968-03-28  New York City
0050           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1969-01-29  New York City
0051           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1969-12-05  New York City
0052           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1968-11-24  New York City
0053           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1966-10-11         London
0054           Auden, W. H.                                          Typed Letter Signed W. H. Auden to Hugo Kurka 1969-01-11  New York City
0055           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1967-11-14  New York City
0056           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1968-12-29  New York City
0057           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1968-11-13  New York City
0058           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1968-12-13  New York City
0059           Auden, W. H.                                                     Envelope W. H. Auden to Hugo Kurka 1969-02-21  New York City
0060           Auden, W. H.                                      Autograph Letter Signed W. H. Auden to Hugo Kurka 1970-03-15  New York City
0061  Süddeutscher Rundfunk                                         Printed Card Süddeutscher Rundfunk 1960-05-20--1961-05-20      Stuttgart
0062           Auden, W. H.  Autograph Card Signed W. H. Auden and Chester Kallman to Christa Kurka and Hugo Kurka 1961-05-23        Hamburg
0063           Auden, W. H.                                        Autograph Card Signed W. H. Auden to Hugo Kurka 1963-10-23         London
0064           Auden, W. H.                                        Autograph Card Signed W. H. Auden to Hugo Kurka 1963-10-29         Oxford
0065           Auden, W. H.                            Autograph Card Signed W. H. Auden to Hugo Kurka 1965-04-26--1965-05-21         London
0066           Auden, W. H.                                        Autograph Card Signed W. H. Auden to Hugo Kurka 1960-11-19        Chicago
0067           Auden, W. H.                      Autograph Card Signed W. H. Auden to Christa Kurka and Hugo Kurka 1964-09-24         Berlin
0068           Auden, W. H.  Autograph Card Signed W. H. Auden and Chester Kallman to Christa Kurka and Hugo Kurka 1961-05-25      Trondheim
0069       Kallman, Chester                  Autograph Card Signed Chester Kallman to Christa Kurka and Hugo Kurka 1961-06-01        München
```
### Scatter Plots

![Number of Documents per Month](docs_per_month.png)
![Number of Documents per Month by Author](docs_per_month_by_author.png)
