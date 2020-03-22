use polls;

/*
 * все ответы пользователя, которые он когда-либо давал
 */
select 
    ps.poll_id, 
    pq.idx as q_idx,
    pq.type as q_type,
    pq.text as q_text,
    pa.idx as a_idx,
    pa.text as a_text,
    abu.user_text as a_usertext,
    abu.int_number as a_int,
    pr.cityname as city
from answers_by_users as abu
join answers as pa on pa.id = abu.answer_id
join questions as pq on pa.question_id = pq.id
join screens as ps on pq.screen_id = ps.id
left join regions as pr on pr.id = abu.int_number and pq.type = 'REGION'
where abu.user_id = 2287428;


/*
 * "содержимое" опроса - вопросы и ответы
 */
select 
	p.id,
	p.name,
	s.idx as s_idx,
	q.idx as q_idx,
	q.type as q_type,
	q.show_if as q_show,
	q.text as q_text,
	a.idx as a_idx,
	a.show_if as a_show,
	a.text as a_text
from answers a
join questions as q on a.question_id = q.id
join screens as s on q.screen_id = s.id
join polls p on s.poll_id = p.id
where p.id = 839;


/*
 * Количество пользователей и их состояние в опросах по дням
 */

select
DDMMYY_started,
poll_status,
count(distinct user_id) as cnt_user
from 
    (SELECT user_id,pc.poll_id,
    date(time_poll_started) as DDMMYY_started,
    screen_id,
    psc.is_terminal,psc.is_win,
    (case when psc.is_terminal=1 and psc.is_win=1 then 'finished'
         when psc.is_terminal=1 and psc.is_win=0 then 'filter_out'
         when psc.is_terminal=0 and psc.is_win=0 and time_poll_started is not null then 'started'
         else 'none' end) poll_status
    FROM currentstates pc
    left join screens psc on pc.screen_id=psc.id and pc.poll_id=psc.poll_id
    left join screens scf on pc.poll_id=scf.poll_id and scf.is_terminal=1 and scf.is_win=1
    left join users pu on pc.user_id=pu.id
    group  by user_id,poll_id) t
group by DDMMYY_started,poll_status
order by DDMMYY_started,poll_status;
