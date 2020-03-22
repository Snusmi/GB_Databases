use polls;

/* 
представление polls_summary - краткое саммари по всем опросам
•	id – идентификатор опроса
•	name – название опроса
•	cost – вознаграждение за опрос
•	avg_duration_minutes – средняя продолжительность опроса, минуты
•	first_started  – таймстемп первого захода на опроса 
•	last_started – таймстемп когда начали проходить опрос в последний раз
•	cnt_not_finished – число начавших, но не закончивших
•	cnt_finished – число прошедших опрос до конца
•	cnt_filtered_out – число не подошедших под условия отбора
*/

create or replace view polls_summary (id, name, cost, avg_duration_minutes, first_started, last_started, cnt_not_finished, cnt_finished, cnt_filtered_out) as
select 
poll_id,pp.name,pp.cost, round(avg(duration),1) as avg_duration, min(time_poll_started) as first_started,
max(time_poll_started) as last_started,
sum(case when poll_status='started' then 1 else 0 end) cnt_started_not_finished,
sum(case when poll_status='finished' then 1 else 0 end) cnt_finished,
sum(case when poll_status='filter_out' then 1 else 0 end) cnt_filtered_out
from
( SELECT user_id,pc.poll_id,time_poll_started,time_poll_finished,screen_id,
    psc.is_terminal,psc.is_win, TIMESTAMPDIFF(MINUTE,time_poll_started,time_poll_finished) as duration,
    (case when psc.is_terminal=1 and psc.is_win=1 then 'finished' 
         when psc.is_terminal=1 and psc.is_win=0 then 'filter_out'
         when psc.is_terminal=0 and psc.is_win=0 and time_poll_started is not null then 'started'
         else 'none' end) poll_status
    FROM currentstates pc 
    left join screens psc on pc.screen_id=psc.id and pc.poll_id=psc.poll_id
    group  by user_id,poll_id
) p
left join polls pp on pp.id=p.poll_id
group by  poll_id 
order by  poll_id desc;

select * from polls_summary;


/*
представление points_12m_transactions
транзакции баллов за последние 12 месяцев от текущей даты по категориям и по месяцам
•	category – категория транзакций
•	1m_ago : 12m_ago – сумма за 1й, 2й … 12й месяц от текущей даты
•	total_12m – за 12 месяцев от текущей даты
 */

create or replace view points_12m_transactions (category, 1m_ago, 2m_ago, 3m_ago, 4m_ago, 5m_ago, 6m_ago, 7m_ago, 8m_ago, 9m_ago, 10m_ago, 11m_ago, 12m_ago, total_12m) as
select category,
sum(m1*cnt) as m1,
sum(m2*cnt) as m2,
sum(m3*cnt) as m3,
sum(m4*cnt) as m4,
sum(m5*cnt) as m5,
sum(m6*cnt) as m6,
sum(m7*cnt) as m7,
sum(m8*cnt) as m8,
sum(m9*cnt) as m9,
sum(m10*cnt) as m10,
sum(m11*cnt) as m11,
sum(m12*cnt) as m12,
sum(m999*cnt) as m999
from
(select category,m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12,m999,
sum(points) as cnt,
count(*) cnt_operations,
count(DISTINCT user_id) cnt_user
from
(SELECT category,points,
        user_id,
    (case when TIMESTAMPDIFF(MONTH,pc.time_created,now())<=1 then 1 else 0 end) m1,
    (case when (TIMESTAMPDIFF(MONTH,pc.time_created,now())<=2 and TIMESTAMPDIFF(MONTH,pc.time_created,now())>1)  then 1 else 0 end) m2,
    (case when (TIMESTAMPDIFF(MONTH,pc.time_created,now())<=3 and TIMESTAMPDIFF(MONTH,pc.time_created,now())>2)  then 1 else 0 end) m3,
    (case when (TIMESTAMPDIFF(MONTH,pc.time_created,now())<=4 and TIMESTAMPDIFF(MONTH,pc.time_created,now())>3)  then 1 else 0 end) m4,
    (case when (TIMESTAMPDIFF(MONTH,pc.time_created,now())<=5 and TIMESTAMPDIFF(MONTH,pc.time_created,now())>4)  then 1 else 0 end) m5,
    (case when (TIMESTAMPDIFF(MONTH,pc.time_created,now())<=6 and TIMESTAMPDIFF(MONTH,pc.time_created,now())>5)  then 1 else 0 end) m6,
    (case when (TIMESTAMPDIFF(MONTH,pc.time_created,now())<=7 and TIMESTAMPDIFF(MONTH,pc.time_created,now())>6)  then 1 else 0 end) m7,
    (case when (TIMESTAMPDIFF(MONTH,pc.time_created,now())<=8 and TIMESTAMPDIFF(MONTH,pc.time_created,now())>7)  then 1 else 0 end) m8,
    (case when (TIMESTAMPDIFF(MONTH,pc.time_created,now())<=9 and TIMESTAMPDIFF(MONTH,pc.time_created,now())>8)  then 1 else 0 end) m9,
    (case when (TIMESTAMPDIFF(MONTH,pc.time_created,now())<=10 and TIMESTAMPDIFF(MONTH,pc.time_created,now())>9)  then 1 else 0 end) m10,
    (case when (TIMESTAMPDIFF(MONTH,pc.time_created,now())<=11 and TIMESTAMPDIFF(MONTH,pc.time_created,now())>10)  then 1 else 0 end) m11,
    (case when (TIMESTAMPDIFF(MONTH,pc.time_created,now())<=12 and TIMESTAMPDIFF(MONTH,pc.time_created,now())>11)  then 1 else 0 end) m12,
    (case when TIMESTAMPDIFF(MONTH,pc.time_created,now())<=12  then 1 else 0 end) m999
FROM points_transactions pc) t1
GROUP BY category,m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12,m999) t2
group by category;

select * from points_12m_transactions;
