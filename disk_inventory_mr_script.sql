use master;
go
DROP DATABASE IF EXISTS disk_inventoryMR;
go
CREATE DATABASE disk_inventoryMR;
go
use disk_inventoryMR;
go
-- create login, user & grant read permissions
IF SUSER_ID('diskUser') IS NULL  -- login can be created before db
	CREATE LOGIN diskUser 
	WITH PASSWORD = 'Pa$$w0rd',
	DEFAULT_DATABASE = disk_inventoryMR;
CREATE USER diskUser;				-- create after use statement
ALTER ROLE db_datareader
	ADD MEMBER diskUser;
go
--create lookup tables
CREATE TABLE artist_type
	(
	artist_type_id			INT NOT NULL PRIMARY KEY IDENTITY,
	description				VARCHAR(20) NOT NULL	-- char/varchar works
	);
CREATE TABLE disk_type
	(
	disk_type_id			INT NOT NULL PRIMARY KEY IDENTITY,
	description				VARCHAR(20) NOT NULL
	);
CREATE TABLE genre
	(
	genre_id				INT NOT NULL PRIMARY KEY IDENTITY,
	description				VARCHAR(20) NOT NULL
	);
CREATE TABLE status
	(
	status_id				INT NOT NULL PRIMARY KEY IDENTITY,
	description				VARCHAR(20) NOT NULL
	);
-- create borrower, disk, artist
CREATE TABLE borrower
	(
	borrower_id				INT NOT NULL PRIMARY KEY IDENTITY,
	f_name					NVARCHAR(60) NOT NULL,
	l_name					NVARCHAR(60) NOT NULL,
	phone_num				VARCHAR(15) NOT NULL
	);
CREATE TABLE disk
	(
	disk_id					INT NOT NULL PRIMARY KEY IDENTITY,
	disk_name				NVARCHAR(60) NOT NULL,
	release_date			DATE NOT NULL,
	genre_id				INT NOT NULL REFERENCES genre(genre_id),
	status_id				INT NOT NULL REFERENCES status(status_id),
	disk_type_id			INT NOT NULL REFERENCES disk_type(disk_type_id)
	);
CREATE TABLE artist
	(
	artist_id			INT NOT NULL PRIMARY KEY IDENTITY,
	f_name				NVARCHAR(60) NOT NULL,
	l_name				NVARCHAR(60) NULL,
	artist_type_id		INT NOT NULL REFERENCES artist_type(artist_type_id)
	);
-- create relationship tables
CREATE TABLE disk_has_borrower
	(
	disk_has_borrower_id	INT NOT NULL PRIMARY KEY IDENTITY,
	borrowed_date			DATETIME2 NOT NULL,
	due_date				DATETIME2 NOT NULL DEFAULT (GETDATE() + 30),
	returned_date			DATETIME2 NULL,
	borrower_id				INT NOT NULL REFERENCES borrower(borrower_id),
	disk_id					INT NOT NULL REFERENCES disk(disk_id)		
	);
CREATE TABLE disk_has_artist
	(
	disk_has_artist_id	INT NOT NULL PRIMARY KEY IDENTITY,
	disk_id				INT NOT NULL REFERENCES disk(disk_id),
	artist_id			INT NOT NULL REFERENCES artist(artist_id)
	UNIQUE (disk_id, artist_id)
	);

go





-- borrower
insert into borrower (f_name, l_name, phone_num) 
values 
('Theadora', 'Buten', '533-448-6020'),
('Pattie', 'Fetters', '381-969-3688'),
('Romola', 'Covelle', '672-725-2164'),
('Kaitlyn', 'Hightown', '268-680-7772'),
('Glynda', 'Grinin', '499-459-1374'),
('Karilynn', 'Brand-Hardy', '775-923-3491'),
('Hoebart', 'Wyatt', '298-876-7581'),
('Dorothee', 'Hamblin', '638-899-4511'),
('Leia', 'Harbertson', '288-426-2522'),
('Fredrick', 'Dalgleish', '530-590-0406'),
('Ely', 'Sheward', '120-298-6506'),
('Kameko', 'Selbie', '264-571-0734'),
('Shela', 'Lober', '720-965-4034'),
('Hersh', 'Bryant', '243-337-6992'),
('Coriss', 'Hollow', '466-578-7542'),
('Anetta', 'Sneddon', '327-261-9726'),
('Hilda', 'Glascott', '607-516-1725'),
('Gibb', 'Sara', '979-976-1196'),
('Dru', 'Ertelt', '817-586-3786'),
('Porter', 'Mateja', '636-754-4339'),
('Rey', 'Rosita', '970-485-3944');

-- Disk Type
Insert Into disk_type(description)
Values
('cd'),
('Vinyl'),
('Cassette'),
('Digital'),
('8-track');

-- Genre
Insert Into genre (description)
Values
('Alternative Rock'),
('Indie'),
('Psychedelic Rock'),
('Singer Songwriter'),
('Classic Rock');


-- status
Insert Into Status (description)
Values
('On Loan'),
('Available');

-- disk
insert into disk (disk_name, release_date, genre_id, status_id, disk_type_id) 
values 
('Rocket', '8/5/2023', 1, 1, 1),
('Ultimate Alternative Wavers', '8/5/2023', 1, 2, 5),
('DSU', '8/5/2023', 1, 1, 3),
('Bedheaded', '8/5/2023', 1, 2, 5),
('Croce', '8/5/2023', 2, 1, 2),
('Pass The Distance', '8/5/2023', 3, 2, 1),
('Freak Out!', '8/5/2023', 2, 1, 3),
('Surfer Rosa', '8/5/2023', 1, 2, 3),
('Lightfoot!', '8/5/2023', 2, 2, 3),
('Please please me', '8/5/2023', 2, 1, 4),
('Dissed and Dismissed', '8/5/2023', 1, 2, 1),
('Tea for the Tillerman', '8/5/2023', 3, 1, 4),
('Led Zeppellin II', '8/5/2023', 2, 1, 1),
('Five Leaves left', '8/5/2023', 4, 1, 4),
('Dance Manatee', '8/5/2023', 5, 2, 5),
('Fly Me to the Moon', '8/5/2023', 1, 2, 5),
('Hi How are you', '8/5/2023', 4, 1, 4),
('Execution Ground', '8/5/2023', 5, 1, 4);

-- disc_has_borrower
insert into disk_has_borrower (borrowed_date, due_date, returned_date, borrower_id, disk_id) 
values 
('8/5/2023', '12/21/2022', '3/21/2023', 1, 10),
('4/24/2023', '8/12/2023', '11/10/2022', 12, 2),
('4/23/2023', '11/12/2022', '5/9/2023', 3, 3),
('8/5/2023', '12/21/2022', '3/21/2023', 14, 8),
('4/24/2023', '8/12/2023', '11/10/2022', 5, 17),
('4/23/2023', '11/12/2022', '5/9/2023', 16, 18),
('12/13/2022', '6/14/2023', '5/14/2023', 8, 7),
('3/1/2023', '8/12/2023', '9/17/2023', 8, 8),
('5/17/2023', '12/26/2022', '7/21/2023', 16, 9),
('8/30/2023', '11/22/2022', '5/31/2023', 10, 10),
('4/15/2023', '10/9/2022', '12/29/2022', 11, 1),
('8/13/2023', '6/4/2023', '8/16/2023', 12, 12),
('5/14/2023', '12/12/2022', '10/30/2022', 13, 13),
('9/11/2023', '1/29/2023', '11/12/2022', 11, 11),
('5/23/2023', '6/15/2023', '6/4/2023', 5, 15),
('3/5/2023', '1/20/2023', '5/22/2023', 16, 5),
('4/7/2023', '7/28/2023', '1/14/2023', 7, 7),
('7/17/2023', '3/5/2023', '1/26/2023', 18, 8);

-- Artist type
Insert into artist_type (description)
Values
('Alternative Rock'),
('Classic Rock'),
('Psychedelic Rock'),
('Singer Songwriter'),
('Indie');

-- Artist
Insert Into artist (f_name, l_name, artist_type_id)
Values 
('Alex', 'G', 1),
('Built to Spill', Default, 1),
('Bedhead', Default, 1 ),
('Jim', 'Croce', 2),
('Simon', 'Finn', 3),
('The Mothers of Invention', Default, 2),
('The Pixies', Default, 1),
('Gordon', 'Lightfoot', 2),
('The Beatles', Default, 2),
('Tony', 'Molina', 1),
('Cat', 'Stevens', 2),
('Led Zeppelin', Default, 3),
('Nick', 'Drake', 4),
('Animal Collective', Default, 5),
('Daniel', 'Johnston', 1);

-- disk_has_artist
Insert Into disk_has_artist(disk_id, artist_id) 
Values
(4, 1),
(6, 3),
(14, 4),
(18, 15),
(15, 5),
(4, 8),
(9, 1),
(12, 13),
(16, 7),
(15, 2),
(3, 11),
(1, 12),
(2, 14);


-- QUERIES --
use disk_inventoryMR;
go
--5 (incorrect)
-- Creates a view that shows borrowers who have not borrowed a disk.
Create View View_Borrower_No_Loans_Join As
Select l_name, f_name
From borrower 
	Left Join disk_has_borrower On
	borrower.borrower_id = disk_has_borrower.borrower_id
go
Select * From View_Borrower_No_Loans_Join;	

--1
-- Shows all disks in disk_inventoryMR including type, status, and genre.
Select disk_name, release_date, 
	disk_type.description As type, status.description As status,
	genre.description As genre
From disk 
	Left Join status
	On disk.status_id = status.status_id
	Left Join disk_type
	On disk.disk_type_id = disk_type.disk_type_id
	Left Join genre
	On disk.genre_id = genre.genre_id;

--2
-- Shows all borrowed disks and their borrowers.
Select l_name, f_name, disk_name, borrowed_date, returned_date
From borrower
	Left Join disk_has_borrower
	On borrower.borrower_id = disk_has_borrower.borrower_id
	Left Join disk
	On disk.disk_id = borrower.borrower_id;

--3 (incorrect) 
-- Shows disks borrowed more than once.
Select disk_name, COUNT(*) As times_borrowed
From disk
Group By disk_name
Having COUNT(*) < 2;


--Select * From artist;
--Select * From artist_type;
--Select * From borrower;
--Select * From disk;
--Select * From disk_has_artist;
--Select * From disk_has_borrower;
--Select * From disk_type;
--Select * From genre;
--Select * From status;






