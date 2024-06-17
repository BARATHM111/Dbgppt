
-- Create a table for students' marks
CREATE TABLE student_marks (
    roll_number INT,
    subject VARCHAR(50),
    marks_scored INT
);

-- Insert random marks for 20 students in 5 subjects
INSERT INTO student_marks (roll_number, subject, marks_scored) VALUES
(1, 'Maths', 85),
(1, 'Science', 78),
(1, 'Physics', 91),
(1, 'Chemistry', 76),
(1, 'English', 84),
(2, 'Maths', 73),
(2, 'Science', 88),
(2, 'Physics', 77),
(2, 'Chemistry', 92),
(2, 'English', 80),
(3, 'Maths', 68),
(3, 'Science', 74),
(3, 'Physics', 89),
(3, 'Chemistry', 85),
(3, 'English', 90),
(4, 'Maths', 90),
(4, 'Science', 83),
(4, 'Physics', 78),
(4, 'Chemistry', 88),
(4, 'English', 79),
(5, 'Maths', 82),
(5, 'Science', 75),
(5, 'Physics', 84),
(5, 'Chemistry', 70),
(5, 'English', 77),
(6, 'Maths', 79),
(6, 'Science', 90),
(6, 'Physics', 86),
(6, 'Chemistry', 83),
(6, 'English', 72),
(7, 'Maths', 88),
(7, 'Science', 77),
(7, 'Physics', 85),
(7, 'Chemistry', 74),
(7, 'English', 81),
(8, 'Maths', 76),
(8, 'Science', 79),
(8, 'Physics', 87),
(8, 'Chemistry', 72),
(8, 'English', 91),
(9, 'Maths', 85),
(9, 'Science', 80),
(9, 'Physics', 83),
(9, 'Chemistry', 78),
(9, 'English', 74),
(10, 'Maths', 77),
(10, 'Science', 82),
(10, 'Physics', 80),
(10, 'Chemistry', 75),
(10, 'English', 79),
(11, 'Maths', 84),
(11, 'Science', 87),
(11, 'Physics', 76),
(11, 'Chemistry', 85),
(11, 'English', 78),
(12, 'Maths', 83),
(12, 'Science', 76),
(12, 'Physics', 92),
(12, 'Chemistry', 80),
(12, 'English', 81),
(13, 'Maths', 91),
(13, 'Science', 85),
(13, 'Physics', 79),
(13, 'Chemistry', 77),
(13, 'English', 86),
(14, 'Maths', 75),
(14, 'Science', 89),
(14, 'Physics', 82),
(14, 'Chemistry', 76),
(14, 'English', 80),
(15, 'Maths', 79),
(15, 'Science', 74),
(15, 'Physics', 85),
(15, 'Chemistry', 87),
(15, 'English', 88),
(16, 'Maths', 86),
(16, 'Science', 78),
(16, 'Physics', 80),
(16, 'Chemistry', 92),
(16, 'English', 83),
(17, 'Maths', 78),
(17, 'Science', 88),
(17, 'Physics', 84),
(17, 'Chemistry', 71),
(17, 'English', 87),
(18, 'Maths', 80),
(18, 'Science', 75),
(18, 'Physics', 89),
(18, 'Chemistry', 77),
(18, 'English', 82),
(19, 'Maths', 87),
(19, 'Science', 90),
(19, 'Physics', 83),
(19, 'Chemistry', 74),
(19, 'English', 85),
(20, 'Maths', 81),
(20, 'Science', 84),
(20, 'Physics', 77),
(20, 'Chemistry', 80),
(20, 'English', 78);

-- Calculate total and average marks for each student
SELECT roll_number,
       SUM(marks_scored) AS total_marks,
       AVG(marks_scored) AS average_marks
FROM student_marks
GROUP BY roll_number;

-- Calculate the class total and average
SELECT SUM(marks_scored) AS class_total,
       AVG(marks_scored) AS class_average
FROM student_marks;