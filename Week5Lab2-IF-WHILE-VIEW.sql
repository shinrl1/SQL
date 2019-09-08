/*
Using Transact-SQL : Exercises
------------------------------------------------------------

Exercises for Section 15


15.1    Develop a view [BigPaperInstance] that finds the 10 paper instances
		with the most enrolments. Show the paperID, paper name,
		semesterID, start date and end date of the paper instance.

		DECLARE @topten = 
	create view BigPaperInstance
	select * from PaperInstance pI 
	join Paper p on pI.PaperID = p.PaperID 
	join Semester s on s.SemesterID = pI.semesterID
	where 
*/
create view BigPaperInstance
as
select * from (
	select top 10 max(tp.Counting) as [Enrolment Count per Paper], PaperID from
		(select p.PaperID, 
		p.PaperName, max(ec.EnrolmentCount) as Counting from
			(select PaperID, SemesterID, count(*) as EnrolmentCount
			from Enrolment
			group by PaperID, SemesterID) ec
		join Paper p on ec.PaperID = p.PaperID
		group by p.PaperName, p.PaperID) tp
	group by tp.Counting, tp.PaperID);

select * from BigPaperInstance

/* fnd out what's up with views */

	select max(ae.AverageEnrolment) as MaximumAvgEnrolment, ae.PaperID, ae.PaperName  from






15.2    Develop a view [SmallPaper] that finds the 10 paper instances
		with the least (lowest number of) enrolments. Show the paperID, paper name,
		semesterID, start date and end date of the paper instance.


15.3	Write a view that lists all the current first year students

create view FirstYears
as
select * from Enrolment 
/*join Paper on Enrolment.PaperID = Paper.PaperID what is going on
with views and joins argg! */
where LEFT(Enrolment.PaperID, 3) = 'IN5' ;

select * from FirstYears;
***************************************************************************************

		You can reference a Database table even if you are not 
		currently connected to it as long as you use its fully qualified domain name.
		The following two questions are using the countries table in the World Database.
		You can use this to find the FQDN for World using a new query pointed at that Database:

			select
				 @@SERVERNAME [server name],
				 DB_NAME() [database name],
				 SCHEMA_NAME(schema_id) [schema name], 
				 name [table name],
				 object_id,
				 "fully qualified name (FQN)" =
				 concat(QUOTENAME(DB_NAME()), '.', QUOTENAME(SCHEMA_NAME(schema_id)),'.', QUOTENAME(name))
			from sys.tables
			where type = 'U' -- USER_TABLE


15.4    Develop a view [ConsonantCountry] that lists the countries that have a name
		starting with a consonant (b c d f g h j k l m n p q r s t v w x y z).
		Show the code and name of each country.


15.5   Develop a view [RecentlyIndependentCountry] that lists countries that 
		gained their independence within the last 100 years. 
		Make sure the view adjusts the resultset to take account of the date when it is run.

*/

/*