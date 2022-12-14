/* 1 задание (Отобрать различные (уникальные) элементы столбца amount таблицы book.) */

select distinct amount
from book

/* 2 задание (Посчитать, количество различных книг и количество экземпляров книг каждого автора , хранящихся на складе.  Столбцы назвать Автор, Различных_книг и Количество_экземпляров соответственно.) */

select author AS Автор,  count(distinct title) AS Различных_книг, sum(amount) AS Количество_экземпляров
from book
group by author

/* 3 задание (Вывести фамилию и инициалы автора, минимальную, максимальную и среднюю цену книг каждого автора . Вычисляемые столбцы назвать Минимальная_цена, Максимальная_цена и Средняя_цена соответственно.) */

select author, min(price) AS Минимальная_цена, max(price) AS Максимальная_цена, avg(price) Средняя_цена
from book 
group by author

/* 4 задание (Для каждого автора вычислить суммарную стоимость книг S (имя столбца Стоимость), а также вычислить налог на добавленную стоимость  для полученных сумм (имя столбца НДС ) , который включен в стоимость и составляет k = 18%,  а также стоимость книг  (Стоимость_без_НДС) без него. Значения округлить до двух знаков после запятой. В запросе для расчета НДС(tax)  и Стоимости без НДС(S_without_tax) использовать следующие формулы:) */

select author, 
sum(price*amount) AS Стоимость,
round(sum(price*amount)*0.18/1.18, 2) AS НДС,
round(sum(price*amount)/1.18, 2) AS Стоимость_без_НДС
from book
group by author

/* 5 задание (Вывести  цену самой дешевой книги, цену самой дорогой и среднюю цену уникальных книг на складе. Названия столбцов Минимальная_цена, Максимальная_цена, Средняя_цена соответственно. Среднюю цену округлить до двух знаков после запятой.) */

select min(price) AS Минимальная_цена , max(price) AS Максимальная_цена, round(avg(price),2) AS Средняя_цена
from book

/* 6 задание (Вычислить среднюю цену и суммарную стоимость тех книг, количество экземпляров которых принадлежит интервалу от 5 до 14, включительно. Столбцы назвать Средняя_цена и Стоимость, значения округлить до 2-х знаков после запятой.) */

select round(avg(price),2) AS Средняя_цена, sum(price*amount) AS Стоимость 
from book
where amount between 5 and 14;

/* 7 задание (Посчитать стоимость всех экземпляров каждого автора без учета книг «Идиот» и «Белая гвардия». В результат включить только тех авторов, у которых суммарная стоимость книг (без учета книг «Идиот» и «Белая гвардия») более 5000 руб. Вычисляемый столбец назвать Стоимость. Результат отсортировать по убыванию стоимости.) */

select author, sum(price*amount) AS Стоимость
from book 
where title <> 'Идиот' and title <> 'Белая гвардия'
group by author 
having sum(price*amount) > 5000
order by Стоимость desc 


