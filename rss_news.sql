drop table rss_news;
create table rss_news(
    no number(8) primary key,
    title varchar2(500),
    link varchar2(300),
    pubDate Date
);

drop sequence rss_news_seq;
create sequence rss_news_seq nocache;

select * from rss_news;
