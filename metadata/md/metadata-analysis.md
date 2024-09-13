## `input_img_id.csv` analysis report
### `df.isnull().sum()`
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
## cleaned document data
```
            author                                                                     title         place
doc                                                                                                       
0001  Auden, W. H.  Autograph Letter Signed W. H. Auden to Hugo Kurka 1960-07-25--1969-07-25  Kirchstetten
0002  Auden, W. H.              Autograph Letter Signed W. H. Auden to Hugo Kurka 1964-09-08  Kirchstetten
0003  Auden, W. H.              Autograph Letter Signed W. H. Auden to Hugo Kurka 1965-05-24  Kirchstetten
0004  Auden, W. H.              Autograph Letter Signed W. H. Auden to Hugo Kurka 1964-10-07  Kirchstetten
0005  Auden, W. H.              Autograph Letter Signed W. H. Auden to Hugo Kurka 1967-05-09  Kirchstetten
0006  Auden, W. H.              Autograph Letter Signed W. H. Auden to Hugo Kurka 1967-06-05  Kirchstetten
0007  Auden, W. H.              Autograph Letter Signed W. H. Auden to Hugo Kurka 1965-07-28  Kirchstetten
0008  Auden, W. H.              Autograph Letter Signed W. H. Auden to Hugo Kurka 1965-04-16        Berlin
0009  Auden, W. H.              Autograph Letter Signed W. H. Auden to Hugo Kurka 1966-06-29  Kirchstetten
0010  Auden, W. H.           Autograph Letter Signed W. H. Auden to Christa Kurka 1969-08-27  Kirchstetten
0011  Auden, W. H.              Autograph Letter Signed W. H. Auden to Hugo Kurka 1965-06-27  Kirchstetten
0012  Auden, W. H.              Autograph Letter Signed W. H. Auden to Hugo Kurka 1964-11-08        Berlin
0013  Auden, W. H.              Autograph Letter Signed W. H. Auden to Hugo Kurka 1969-08-20  Kirchstetten
0014  Auden, W. H.              Autograph Letter Signed W. H. Auden to Hugo Kurka 1964-12-08        Berlin
0015  Auden, W. H.              Autograph Letter Signed W. H. Auden to Hugo Kurka 1964-06-25  Kirchstetten
0016  Auden, W. H.              Autograph Letter Signed W. H. Auden to Hugo Kurka 1968-08-26  Kirchstetten
0017  Auden, W. H.              Autograph Letter Signed W. H. Auden to Hugo Kurka 1965-08-16  Kirchstetten
0018  Auden, W. H.              Autograph Letter Signed W. H. Auden to Hugo Kurka 1964-06-19  Kirchstetten
0019  Auden, W. H.              Autograph Letter Signed W. H. Auden to Hugo Kurka 1966-05-04  Kirchstetten
0020  Auden, W. H.              Autograph Letter Signed W. H. Auden to Hugo Kurka 1965-08-04  Kirchstetten
0021  Auden, W. H.              Autograph Letter Signed W. H. Auden to Hugo Kurka 1964-09-16  Kirchstetten
0022  Auden, W. H.              Autograph Letter Signed W. H. Auden to Hugo Kurka 1964-09-28  Kirchstetten
0023  Auden, W. H.              Autograph Letter Signed W. H. Auden to Hugo Kurka 1966-05-20  Kirchstetten
0024  Auden, W. H.              Autograph Letter Signed W. H. Auden to Hugo Kurka 1964-09-16  Kirchstetten
```
## scatter plot

![number of documents per month](docs_per_month.png)