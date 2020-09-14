Delimiter $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_StaffMembers_SelByStaffUid`(

/*

	Call sp_StaffMembers_SelByStaffUid('1583429768059', '1523370179180');

*/
	
    _staffUid varchar(50),
    _tenentId varchar(50)
)
Begin

	Declare exit handler for sqlexception
	Begin
	
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE,
									@errorno = MYSQL_ERRNO,
									@errortext = MESSAGE_TEXT;
									
		Set @Message = CONCAT('ERROR ', @errorno ,  ' (', @sqlstate, '): ', @errortext);
		RollBack;
		Call sp_LogException(@Message, @OperationStatus, 'sp_StaffMembers_SelByStaffUid', 1, 0, @Result);
	end;
	
	Select sm.StaffMemberUid, sm.SchoolTenentId, sm.ClassTeacherForClass, cd.ClassDetailId, sm.FirstName , sm.LastName, 
    sm.Gender, sm.Dob, sm.Doj, sm.MobileNumber, sm.AlternetNumber, sm.ImageUrl, sm.Email, sm.Address, 
    sm.City, sm.State, sm.Pincode, sm.Subjects, sm.Type, sm.QualificationId, sm.DesignationId, sm.CreatedOn, 
    sm.UpdatedOn, sm.CreatedBy, sm.UpdatedOn, cd.Class, cd.Section, qt.SchoolUniversityName, qt.DegreeName, 
    qt.Grade, qt.Position, qt.MarksObtain, qt.Title, qt.ProofOfDocumentationPath, qt.ExprienceInYear, 
    qt.ExperienceInMonth, qt.QualificatoinId, qt.DegreeName, qt.Grade, qt.Position, qt.MarksObtain, qt.SchoolUniversityName, 
	qt.ProofOfDocumentationPath, qt.ExprienceInYear, qt.ExperienceInMonth from staffmembers sm 
    Inner join qualificatointable qt on qt.QualificatoinId = sm.QualificationId
    Left join ClassDetail cd on cd.ClassDetailId = sm.ClassTeacherForClass
    where sm.StaffMemberUid = _staffUid;
    
    Select f.FileUid, f.ProfileUid, f.FilePath, f.FileName, f.FileExtension 
	from Files f where f.ProfileUid = _staffUid;
End$$
DELIMITER ;
