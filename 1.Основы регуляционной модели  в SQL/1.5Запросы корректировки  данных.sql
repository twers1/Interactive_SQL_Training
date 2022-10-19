/* 1 задание (Создать таблицу поставка (supply), которая имеет ту же структуру, что и таблиц book.) */

create table supply (
    supply_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    author VARCHAR(30),
    price DECIMAL(8,2),
    amount INT
);

/* 2 задание (Занесите в таблицу supply четыре записи, чтобы получилась следующая таблица:) */

insert into supply (title, author, price, amount)
VALUES('Лирика', 'Пастернак Б.Л.', 518.99, 2);


insert into supply (title, author, price, amount)
VALUES('Черный человек', 'Есенин С.А.',	570.20 ,6 );


insert into supply (title, author, price, amount)
VALUES('Белая гвардия', 'Булгаков М.А.',540.50 ,7 );


insert into supply (title, author, price, amount)
VALUES('Идиот', 'Достоевский Ф.М.',360.80 , 3);
SELECT * from supply

/* 3 задание (Добавить из таблицы supply в таблицу book, все книги, кроме книг, написанных Булгаковым М.А. и Достоевским Ф.М.) */

INSERT INTO book (title, author, price, amount) 
SELECT title, author, price, amount 
FROM supply
where author not in('Булгаков М.А.','Достоевский Ф.М.');
SELECT * FROM book

/* 4 задание (Занести из таблицы supply в таблицу book только те книги, авторов которых нет в  book.) */

INSERT INTO book (title, author, price, amount) 
SELECT title, author, price, amount 
FROM supply
WHERE author NOT IN (
        SELECT author
        FROM book
      );

SELECT * FROM book;

/* 5 задание (Уменьшить на 10% цену тех книг в таблице book, количество которых принадлежит интервалу от 5 до 10, включая границы.) */

UPDATE book 
SET price = 0.9 * price 
WHERE amount between 5 and 10;

SELECT * FROM book;

/* 6 задание (В таблице book необходимо скорректировать значение для покупателя в столбце buy таким образом, чтобы оно не превышало количество экземпляров книг, указанных в столбце amount. А цену тех книг, которые покупатель не заказывал, снизить на 10%.) */

UPDATE book 
SET buy = IF(buy > amount, amount, buy), 
    price = IF(buy=0, 0.9*price, price);
SELECT * FROM book;

/* 7 задание (Для тех книг в таблице book , которые есть в таблице supply, не только увеличить их количество в таблице book ( увеличить их количество на значение столбца amountтаблицы supply), но и пересчитать их цену (для каждой книги найти сумму цен из таблиц book и supply и разделить на 2).) */

UPDATE book, supply 
SET book.amount = book.amount + supply.amount,
book.price = (book.price + supply.price)/2
WHERE book.title = supply.title AND book.author = supply.author;
SELECT * FROM book;

/* 8 задание (Удалить из таблицы supply книги тех авторов, общее количество экземпляров книг которых в таблице book превышает 10.) */

DELETE FROM supply 
WHERE author IN (
        SELECT author
        FROM book
        group by author
        having sum(amount)  > 10
      );


SELECT * FROM supply;

/* 9 задание (Создать таблицу заказ (ordering), куда включить авторов и названия тех книг, количество экземпляров которых в таблице book меньше среднего количества экземпляров книг в таблице book. В таблицу включить столбец   amount, в котором для всех книг указать одинаковое значение - среднее количество экземпляров книг в таблице book.) */

CREATE TABLE ordering AS
SELECT author, title, 
   (SELECT round(AVG(amount)) 
    FROM book
   ) AS amount
from book
where amount < (SELECT round(AVG(amount)) FROM book);

SELECT * FROM ordering;




