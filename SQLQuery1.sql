IF EXISTS (SELECT*FROM sys.databases WHERE name = 'MyBlog')
DROP DATABASE MyBlog
GO
--CREATE DATABASE MYBLOG
CREATE DATABASE MyBlog
GO
--CREATE THE TABLE
USE MyBlog
CREATE TABLE Users(
	UserID INT IDENTITY,
	UserName VARCHAR(20),
	Password VARCHAR(30),
	Email VARCHAR(30) UNIQUE,
	Address NVARCHAR(200)
	CONSTRAINT pk_User PRIMARY KEY (UserID)
	)
CREATE TABLE Posts(
	PostID INT IDENTITY,
	Title NVARCHAR(200),
	Content NVARCHAR(MAX),
	Tag NVARCHAR(100),
	Status BIT,
	CreateTime DATETIME DEFAULT GETDATE(),
	UpdateTime DATETIME,
	UserID INT,
	CONSTRAINT pk_Posts PRIMARY KEY (PostID),
	CONSTRAINT fk_User FOREIGN KEY (UserID) REFERENCES Users(UserID)
	)
CREATE TABLE Comments(
	CommentID INT IDENTITY,
	Content NVARCHAR(500),
	Status BIT,
	CreateTime DATETIME DEFAULT GETDATE(),
	Author NVARCHAR(30),
	Email VARCHAR(50) NOT NULL,
	PostID INT,
	CONSTRAINT pk_Comments PRIMARY KEY (CommentID),
	CONSTRAINT fk_Posts FOREIGN KEY (PostID) REFERENCES Posts(PostID)
	)
GO
SET DATEFORMAT DMY
--CREATE CONSTRAIN TO ENSURE VALUE OF EMAIL CONTAIN '@' CHARACTER
ALTER TABLE Users
	ADD CONSTRAINT chk_Email CHECK(Email LIKE '%@%');
GO
--CREATE UNIQUE, NONCLUSTERED INDEX ON USENAME COLUMN ON USERS
CREATE UNIQUE NONCLUSTERED INDEX IX_UserName ON Users(UserName);
GO
--INSERT RECORD INTO TABLE
INSERT INTO Users VALUES
('SyedAbbas', 'SjLXpiarHSlz+6AG+H+4QpB/IPRzra','a0@adventure-works.com', '#500-75 OConnor Street'),
('CatherineAbel','8FYdAiY6gWuBsgjCFdg0Uibts','a1@adventure-works.com','#9900 2700 Production Way'),
('KimAbercrombie', 'u5kbN5n84NRE1h/a+ktdRrXucjgrm', 'aaron1@adventure-works.com', '00, rue Saint-Lazare')
INSERT INTO Posts VALUES
('Once Upon A Summertime', 'Orange blossoms have been associated with love for centuries. In ancient China they were seen as a symbol of purity, innocence and chastity so were often associated with young brides','summer', 1, GETDATE(),null, 2),
('Foolproof Chocolate Fudge Cake', 'This particular recipe is especially for those who haven’t baked before, those who feel a bit intimidated by the whole thing, those who have no gear and no idea where to start!', 'Social', 1, GETDATE(), null, 3),
('Super Simple Scones', 'You just can’t beat a cream tea, it’s one of the greatest pleasures offered up in the British countryside. You simply won’t find an old English town without a tea shop with scones in the window and clotted cream ready to go', 'Super Simple Scones', 1, GETDATE(), null, 1)
INSERT INTO Comments VALUES
('Supper', 1, GETDATE(), 'Alex','a3@adventure-works.com', 1),
('dajsjdasdhaskj', 1, GETDATE(), 'Lex Luthor', 'a4@adventure-works.com', 3),
('dfsddfaeddfa', 1, GETDATE(), 'Crack Ken', 'a5@adventure-works.com', 2)
--SELECT POSTING HAS SOCIAL TAG
SELECT PostID, Title, CreateTime, UserID FROM Posts WHERE Tag = 'Social'
--SELECT POSTING THAT HAVE AUTHOR'S EMAIL ABC@GMAIL.COM
SELECT PostID, Title, CreateTime FROM Posts, Users WHERE Email = 'abc@gmail.com'
--COUNT TOTAL COMMENT
SELECT COUNT(CommentID) FROM Comments
