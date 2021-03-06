--
-- Joe Knudsen
-- Infinite Campus Answers
-- 02/19/2020

--1
SELECT COUNT(*),
       CASE WHEN DATENAME(WEEKDAY,[date]) IN ('Saturday','Sunday') 
            THEN 'Weekend' ELSE DATENAME(WEEKDAY,[date]) END
  FROM (SELECT DISTINCT personID, [date] FROM [dbo].[AttendanceRecord]) AS UniqueAttend
  GROUP BY CASE WHEN DATENAME(WEEKDAY,[date]) IN ('Saturday','Sunday') 
                THEN 'Weekend' ELSE DATENAME(WEEKDAY,[date]) END

--2.0
SELECT child.name child, parent.name parent
  FROM dbo.Person child
    JOIN dbo.Person parent
      ON child.parentID1 = parent.personID OR child.parentID2 = parent.personID

--2.1
SELECT child.name child, parent1.name parent1, parent2.name parent2
  FROM dbo.Person child
    LEFT JOIN dbo.Person parent1
           ON child.parentID1 = parent1.personID
	LEFT JOIN dbo.Person parent2
           ON child.parentID2 = parent2.personID
  WHERE parent1.name IS NOT NULL OR parent2.name IS NOT NULL

--3
SELECT SUM(CASE WHEN P.gender = 'Male' THEN 1 END) male,
       SUM(CASE WHEN P.gender = 'Female' THEN 1 END) female
  FROM (SELECT DISTINCT personID FROM dbo.Enrollment) E
  JOIN dbo.Person P
    ON E.personID = P.personId

--4
SELECT P.name,MAX(E.grade) grade,C.name [subject]
  FROM dbo.Person P
  JOIN dbo.Enrollment E
    ON P.personID = E.personID
  JOIN dbo.Schedule S
    ON P.personID = S.personID
  JOIN dbo.Class C
    ON S.classID = C.classID
  GROUP BY P.name,C.name