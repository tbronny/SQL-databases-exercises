--1. What grades are stored in the database?
SELECT * FROM Grade

--2. What emotions may be associated with a poem?
Select * From Emotion

Select po.Id, po.Title, e.Name As Emotion
From Poem po
Inner Join PoemEmotion pe On po.Id = pe.PoemId
Inner Join Emotion e On pe.EmotionId = e.Id

--3. How many poems are in the database?
Select MAX(Id) 
From Poem

--4. Sort authors alphabetically by name. What are the names of the top 76 authors?
Select Top 76 Name
From Author
Order by Name Asc

--5. Starting with the above query, add the grade of each of the authors.
Select Top 76 Author.Name, Grade.Name
From Author
Join Grade On Author.GradeId = Grade.Id
Order by Author.Name Asc

--6. Starting with the above query, add the recorded gender of each of the authors.
Select Top 76 Author.Name, Grade.Name, Gender.Name
From Author
Join Grade On Author.GradeId = Grade.Id
Join Gender On Author.GenderId = Gender.Id
Order by Author.Name Asc

--7. What is the total number of words in all poems in the database?
Select Sum(WordCount)
From Poem

--8. Which poem has the fewest characters?
Select CharCount, Title
From Poem
Where CharCount = (Select Min(CharCount) From Poem)

--9. How many authors are in the third grade?
Select Count(Id)
From Author
Where GradeId = 3

--10. How many total authors are in the first through third grades?
Select Count(Id)
From Author
Where GradeId = 1 or GradeId = 2 or GradeId = 3

--11. What is the total number of poems written by fourth graders?
Select Count(Poem.Id) As TotalPoems
From Poem
Join Author On Poem.AuthorId = Author.Id
Join Grade On Author.GradeId = Grade.Id
Where Author.GradeId = 4

--12. How many poems are there per grade?
Select Grade.Name, Count(Poem.Id) As TotalPoems
From Poem
Join Author On Poem.AuthorId = Author.Id
Join Grade On Author.GradeId = Grade.Id
Group By Grade.Name

--13. How many authors are in each grade? (Order your results by grade starting with 1st Grade)
Select Grade.Name, Count(Author.Id) As TotalAuthors
From Author
Join Grade On Author.GradeId = Grade.Id
Group By Grade.Name

--14. What is the title of the poem that has the most words?
Select Title, WordCount
From Poem
Where WordCount = (Select Max(WordCount) From Poem)

--15. Which author(s) have the most poems? (Remember authors can have the same name.)
Select Top 3 Author.Name, Count(Poem.Id) as NumOfPoems
From Poem
Join Author On Poem.AuthorId = Author.Id
Group By Author.Id, Author.Name
Order By NumOfPoems Desc

--16. How many poems have an emotion of sadness?
Select Count(po.Id) 'NumOfPoems', e.Name
From Poem po
Join PoemEmotion pe On po.Id = pe.PoemId
Join Emotion e On pe.EmotionId = e.Id
Where e.Name = 'Sadness'
Group By e.Name

--17. How many poems are not associated with any emotion?
Select Count(po.Id) 'NumOfPoems', e.Name 'Emotion'
From Poem po
Left Join PoemEmotion pe On po.Id = pe.PoemId
Left Join Emotion e On pe.EmotionId = e.Id
Where e.Name is null
Group By e.Name

--18. Which emotion is associated with the least number of poems?
Select Top 1 Count(po.Id) 'NumOfPoems', e.Name 'Emotion'
From Poem po
Join PoemEmotion pe On po.Id = pe.PoemId
Join Emotion e On pe.EmotionId = e.Id
Group By e.Name
Order By NumOfPoems Asc

--19. Which grade has the largest number of poems with an emotion of joy?
Select Top 1 g.Name As Grade, Count(po.Id) 'NumOfPoems', e.Name 'Emotion'
From Poem po
Join PoemEmotion pe On po.Id = pe.PoemId
Join Emotion e On pe.EmotionId = e.Id
Join Author a On po.AuthorId = a.Id
Join Grade g On g.Id = a.GradeId
Where e.Name = 'Joy'
Group By g.Name, e.Name
Order By NumOfPoems Desc

--20. Which gender has the least number of poems with an emotion of fear?
Select Top 1 ge.Name As Gender, Count(po.Id) 'NumOfPoems', e.Name 'Emotion'
From Poem po
Join PoemEmotion pe On po.Id = pe.PoemId
Join Emotion e On pe.EmotionId = e.Id
Join Author a On po.AuthorId = a.Id
Join Gender ge On a.GenderId = ge.Id
Join Grade g On g.Id = a.GradeId
Where e.Name = 'Fear'
Group By ge.Name, e.Name
Order By NumOfPoems Asc
