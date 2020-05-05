/* create the database */
use Crave2Know;


/* create the tables*/
db.createCollection('Course');
db.createCollection('Student');
db.createCollection('CourseInstance');
db.createCollection('Student_CourseInstance');
db.createCollection('Assignment');
db.createCollection('Student_Assignment');


/* INSERTing Students */
db.Student.insert({
	StudentNumber: 'W0111222',
	FirstName: 'Jill',
	LastName: 'Hill',
	Password: 'Jillh123',
	Address: 'Anywhere Street',
	PhoneNumber: '9021110000'
});

db.Student.insert({
	StudentNumber: 'W0222333',
	FirstName: 'Mike',
	LastName: 'Pike',
	Password: 'Pike321@',
	Address: 'Young Street',
	PhoneNumber: '9020001111'
});

db.Student.insert({
	StudentNumber: 'W0333444',
	FirstName: 'Steve',
	LastName: 'Cleve',
	Password: '@Cleve321',
	Address: 'North Street',
	PhoneNumber: '9021234567'
});


/* INSERTing Courses */
db.Course.insert({
	CourseCode: 'DBAS1007',
	Name: 'Data Fundamentals',
	Description: 'Introduction to Data'
});

db.Course.insert({
	CourseCode: 'PROG1700',
	Name: 'Programming',
	Description: 'Introduction to Programming'
});


/* CREATing a new instance of the Data Fundamentals course */
db.CourseInstance.insert({
	CourseInstanceCode: 'DBAS1007_2018',
	StartDate: '2018-09-07',
	EndDate: '2018-12-14',
	CourseCode: 'DBAS1007'
});


/* CREATing a new instance of the Programming course */
db.CourseInstance.insert({
	CourseInstanceCode: 'PROG1700_2019',
	StartDate: '2019-01-04',
	EndDate: '2019-04-24',
	CourseCode: 'PROG1700'
});


/* Enroll Jill and Mike in the instance of the Data Fundamentals course and Jill and Steve in the instance of the Programming course */
db.Student_CourseInstance.insert({
	Student_CourseInstanceID: 'SCI1',
	StudentNumber: 'W0111222',
	CourseInstanceCode: 'DBAS1007_2018'
});

db.Student_CourseInstance.insert({
	Student_CourseInstanceID: 'SCI2',
	StudentNumber: 'W0222333',
	CourseInstanceCode: 'DBAS1007_2018'
});

db.Student_CourseInstance.insert({
	Student_CourseInstanceID: 'SCI3',
	StudentNumber: 'W0111222',
	CourseInstanceCode: 'PROG1700_2019'
});

db.Student_CourseInstance.insert({
	Student_CourseInstanceID: 'SCI4',
	StudentNumber: 'W0333444',
	CourseInstanceCode: 'PROG1700_2019'
});


/* Create two assignments in the database course and one assignment in the programming course */
db.Assignment.insert({
	AssignmentID: 'A1',
	CourseInstanceCode: 'DBAS1007_2018'
});

db.Assignment.insert({
	AssignmentID: 'A2',
	CourseInstanceCode: 'DBAS1007_2018'
});

db.Assignment.insert({
	AssignmentID: 'A3',
	CourseInstanceCode: 'PROG1700_2019'
});


/* Give the following database assignment grades to Jill Assignment 1: 95 and Assignment 2: 87 */
db.Student_Assignment.insert({
	Student_AssignmentID: 'SA1',
	Grade: '95',
	StudentNumber: 'W0111222',
	AssignmentID: 'A1'
});

db.Student_Assignment.insert({
	Student_AssignmentID: 'SA1',
	Grade: '87',
	StudentNumber: 'W0111222',
	AssignmentID: 'A2'
});


/* Remove Steve from the programming course */
db.Student_CourseInstance.deleteOne({
	StudentNumber: 'W0333444',
	CourseInstanceCode: 'PROG1700_2019'
});


/* Update Jill’s total grade for Programming to a 78 */
db.Student_CourseInstance.update({
StudentNumber: 'W0111222',
CourseInstanceCode: 'PROG1700_2019'
},
{
$set: {
TotalGrade: '78'
}
});


/* Display a list of all courses */
db.Course.find().pretty();


/* Display the last name of the student with the student number of W0333444 */
db.Student.find(
	{ StudentNumber: 'W0333444'},
	{LastName: 1} );


/* Display a list of the assignment grades for student number W0111222 */
db.Student_Assignment.find(
	{ StudentNumber: 'W0111222'},
	{Grade: 1} );


/* Display a list of courses that are being delivered after January 1st, 2019 */
db.CourseInstance.find(
	{ StartDate: { $gt: '2019-01-01' } },
	{CourseInstanceCode: 1} );
