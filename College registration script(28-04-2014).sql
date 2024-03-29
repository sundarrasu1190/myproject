USE [CollegeRegistration]
GO
/****** Object:  Table [dbo].[tblUniversityMaster]    Script Date: 04/28/2014 21:18:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUniversityMaster](
	[UniversityId] [bigint] IDENTITY(1,1) NOT NULL,
	[UniversityName] [nvarchar](30) NULL,
 CONSTRAINT [PK_tblUniversityMaster] PRIMARY KEY CLUSTERED 
(
	[UniversityId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblAccomodationMaster]    Script Date: 04/28/2014 21:18:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAccomodationMaster](
	[AccomodationId] [int] IDENTITY(1,1) NOT NULL,
	[AccomodationName] [nvarchar](5) NULL,
 CONSTRAINT [PK_tblAccomodationMaster] PRIMARY KEY CLUSTERED 
(
	[AccomodationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblZoneMaster]    Script Date: 04/28/2014 21:18:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblZoneMaster](
	[ZoneId] [bigint] IDENTITY(1,1) NOT NULL,
	[ZoneName] [nvarchar](30) NULL,
	[UniversityId] [bigint] NULL,
 CONSTRAINT [PK_tblZoneMaster] PRIMARY KEY CLUSTERED 
(
	[ZoneId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[SPGetUniversityMaster]    Script Date: 04/28/2014 21:18:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SPGetUniversityMaster]
-- =============================================
-- Author     : Sundarrasu.S
-- Create date: 02-04-2014
-- Description:	Load all UniversityMaster details
-- =============================================
as
BEGIN 
SELECT * FROM tblUniversityMaster 
END
GO
/****** Object:  StoredProcedure [dbo].[SPGetAccomodationMaster]    Script Date: 04/28/2014 21:18:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SPGetAccomodationMaster]
-- =============================================
-- Author     : Sundarrasu.S
-- Create date: 02-04-2014
-- Description:	Load all AccomodationMaster details
-- =============================================
as
BEGIN 
SELECT * FROM tblAccomodationMaster 
END
GO
/****** Object:  StoredProcedure [dbo].[SPGetZoneMaster]    Script Date: 04/28/2014 21:18:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SPGetZoneMaster]
-- =============================================
-- Author     : Sundarrasu.S
-- Create date: 02-04-2014
-- Description:	Load all ZoneMaster details
-- =============================================
as
BEGIN 
SELECT * FROM tblZoneMaster 
END
GO
/****** Object:  Table [dbo].[tblCollegeMaster]    Script Date: 04/28/2014 21:18:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCollegeMaster](
	[CollegeId] [bigint] IDENTITY(1,1) NOT NULL,
	[CollegeCode] [nvarchar](8) NULL,
	[CollegeName] [nvarchar](50) NULL,
	[CollegeAddress] [nvarchar](250) NULL,
	[DateOfReopening] [datetime] NULL,
	[EmailId] [nvarchar](30) NULL,
	[Website] [nvarchar](30) NULL,
	[UniversityId] [bigint] NULL,
	[ZoneId] [bigint] NULL,
	[PhoneNumber] [nvarchar](20) NULL,
	[AccomodationId] [int] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_tblCollegeMaster] PRIMARY KEY CLUSTERED 
(
	[CollegeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[SPGetUniName]    Script Date: 04/28/2014 21:18:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SPGetUniName]
-- =============================================
-- Author     : Sundarrasu.S
-- Create date: 21-04-2014
-- Description:	Load University names
-- =============================================
as
BEGIN 
SELECT distinct UM.UniversityName,UM.UniversityId FROM tblCollegeMaster as CM
inner join tblUniversityMaster as UM on CM.UniversityId=UM.UniversityId
END
GO
/****** Object:  StoredProcedure [dbo].[SPGetMaxCollegeId]    Script Date: 04/28/2014 21:18:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SPGetMaxCollegeId]
-- =============================================
-- Author     : Sundarrasu.S
-- Create date: 02-04-2014
-- Description:	Load Maximum of CollegeId value
-- =============================================
as
begin 

SELECT isnull(max(CollegeId)+1,0+1) as CollegeId from tblCollegeMaster

end
GO
/****** Object:  StoredProcedure [dbo].[SPGetDetailsByName]    Script Date: 04/28/2014 21:18:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SPGetDetailsByName]
-- =============================================
-- Author     : Sundarrasu.S
-- Create date: 21-04-2014
-- Modified date: 28-04-2014
-- Description:	Load College details by filter options
-- =============================================
(
 -- Optional Filters for Dynamic Search
@CollegeName nvarchar(50) = NULL,
@EmailId nvarchar(30) = NULL,
@CollegeCode nvarchar(8) = NULL,
@UniversityId Bigint = NULL
)
as
BEGIN 
SET NOCOUNT ON
     
    DECLARE
        @SCollegeName nvarchar(50), 
        @SEmailId nvarchar(30), 
        @SCollegeCode nvarchar(8), 
        @SUniversityId Bigint 
             
    SET @SCollegeName = LTRIM(RTRIM(@CollegeName))
    SET @SEmailId = LTRIM(RTRIM(@EmailId))
    SET @SCollegeCode = LTRIM(RTRIM(@CollegeCode))
    SET @SUniversityId = @UniversityId
    
 SELECT CM.CollegeId,CM.CollegeCode,CM.CollegeName,CM.CollegeAddress,replace(convert(nvarchar(20),CM.DateOfReopening,103),'/','-') as DateOfReopening,
CM.EmailId,CM.Website,UM.UniversityName,ZM.ZoneName,CM.PhoneNumber,AM.AccomodationName FROM tblCollegeMaster as CM
inner join tblAccomodationMaster as AM on CM.AccomodationId=AM.AccomodationId
inner join tblUniversityMaster as UM on CM.UniversityId=UM.UniversityId  and CM.Status=1
inner join tblZoneMaster as ZM on CM.ZoneId=ZM.ZoneId 
where (@SCollegeName IS NULL OR CollegeName LIKE '%' + @SCollegeName + '%')
    AND (@SEmailId IS NULL OR EmailId LIKE '%' + @SEmailId + '%')
    AND (@SCollegeCode IS NULL OR CollegeCode LIKE '%' + @SCollegeCode + '%')    
    AND (@SUniversityId IS NULL OR CM.UniversityId = @SUniversityId)
    ORDER BY CollegeId

END
GO
/****** Object:  StoredProcedure [dbo].[SPGetCollegeMasterById]    Script Date: 04/28/2014 21:18:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SPGetCollegeMasterById]
-- =============================================
-- Author     : Sundarrasu.S
-- Create date: 22-04-2014
-- Description:	Load all CollegeMaster details by college id
-- =============================================
(@CollegeId bigint)
as
BEGIN 
SELECT CM.CollegeId,CM.CollegeCode,CM.CollegeName,CM.CollegeAddress,replace(convert(nvarchar(20),CM.DateOfReopening,103),'/','-') as DateOfReopening,
CM.EmailId,CM.Website,UM.UniversityName,UM.UniversityId,ZM.ZoneName,ZM.ZoneId,CM.PhoneNumber,AM.AccomodationName,AM.AccomodationId FROM tblCollegeMaster as CM
inner join tblAccomodationMaster as AM on CM.AccomodationId=AM.AccomodationId
inner join tblUniversityMaster as UM on CM.UniversityId=UM.UniversityId 
inner join tblZoneMaster as ZM on CM.ZoneId=ZM.ZoneId where CM.Status=1 and CM.CollegeId=@CollegeId
END
GO
/****** Object:  StoredProcedure [dbo].[SPGetCollegeMaster]    Script Date: 04/28/2014 21:18:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SPGetCollegeMaster]
-- =============================================
-- Author     : Sundarrasu.S
-- Create date: 02-04-2014
-- Description:	Load all CollegeMaster details
-- =============================================
as
BEGIN 
SELECT CM.CollegeId,CM.CollegeCode,CM.CollegeName,CM.CollegeAddress,replace(convert(nvarchar(20),CM.DateOfReopening,103),'/','-') as DateOfReopening,
CM.EmailId,CM.Website,UM.UniversityName,ZM.ZoneName,CM.PhoneNumber,AM.AccomodationName FROM tblCollegeMaster as CM
inner join tblAccomodationMaster as AM on CM.AccomodationId=AM.AccomodationId
inner join tblUniversityMaster as UM on CM.UniversityId=UM.UniversityId
inner join tblZoneMaster as ZM on CM.ZoneId=ZM.ZoneId where CM.Status=1
END
GO
/****** Object:  StoredProcedure [dbo].[SPUpdateDetails]    Script Date: 04/28/2014 21:18:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SPUpdateDetails]
-- =============================================
-- Author     : Sundarrasu.S
-- Create date: 21-04-2014
-- Description:	Update College details(Delete operation)
-- =============================================
(

@CollegeId bigint,
@Status bit
)
as

begin

update tblCollegeMaster set Status=@Status
where CollegeId=@CollegeId


end
GO
/****** Object:  StoredProcedure [dbo].[SPSaveandUpdateCollegeMaster]    Script Date: 04/28/2014 21:18:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SPSaveandUpdateCollegeMaster]
-- =============================================
-- Author     : Sundarrasu.S
-- Create date: 02-04-2014
-- Description:	Save CollegeMaster details
-- =============================================
(

@CollegeCode nvarchar(8),
@CollegeName nvarchar(50),
@CollegeAddress nvarchar(250),
@DateOfReopening datetime,
@EmailId nvarchar(30),
@Website nvarchar(30),
@UniversityId bigint,
@ZoneId bigint,
@PhoneNumber nvarchar(20),
@AccomodationId int
)
as
begin
DECLARE @CollegeId bigint
SELECT @CollegeId=CollegeId from tblCollegeMaster where CollegeName=@CollegeName
if @CollegeId is NULL
begin
insert into tblCollegeMaster(CollegeCode,CollegeName,CollegeAddress,DateOfReopening,EmailId,Website,UniversityId,ZoneId,PhoneNumber,AccomodationId)
values(@CollegeCode,@CollegeName,@CollegeAddress,@DateOfReopening,@EmailId,@Website,@UniversityId,@ZoneId,@PhoneNumber,@AccomodationId)
end

else
begin

update tblCollegeMaster set CollegeCode=@CollegeCode,CollegeName=@CollegeName,CollegeAddress=@CollegeAddress,
DateOfReopening=@DateOfReopening,EmailId=@EmailId,Website=@Website,UniversityId=@UniversityId,ZoneId=@ZoneId,PhoneNumber=@PhoneNumber,AccomodationId=@AccomodationId
where CollegeId=@CollegeId


end

end
GO
/****** Object:  StoredProcedure [dbo].[SPGetZoneName]    Script Date: 04/28/2014 21:18:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SPGetZoneName]
-- =============================================
-- Author     : Sundarrasu.S
-- Create date: 21-04-2014
-- Description:	Load Zone names
-- =============================================
as
BEGIN 
SELECT distinct ZM.ZoneId,ZM.ZoneName FROM tblCollegeMaster as CM
inner join tblZoneMaster as ZM on CM.ZoneId=ZM.ZoneId
END
GO
/****** Object:  Default [DF_tblCollegeMaster_Status]    Script Date: 04/28/2014 21:18:55 ******/
ALTER TABLE [dbo].[tblCollegeMaster] ADD  CONSTRAINT [DF_tblCollegeMaster_Status]  DEFAULT ((1)) FOR [Status]
GO
/****** Object:  ForeignKey [FK_tblZoneMaster_tblUniversityMaster]    Script Date: 04/28/2014 21:18:54 ******/
ALTER TABLE [dbo].[tblZoneMaster]  WITH CHECK ADD  CONSTRAINT [FK_tblZoneMaster_tblUniversityMaster] FOREIGN KEY([UniversityId])
REFERENCES [dbo].[tblUniversityMaster] ([UniversityId])
GO
ALTER TABLE [dbo].[tblZoneMaster] CHECK CONSTRAINT [FK_tblZoneMaster_tblUniversityMaster]
GO
/****** Object:  ForeignKey [FK_tblCollegeMaster_tblAccomodationMaster]    Script Date: 04/28/2014 21:18:55 ******/
ALTER TABLE [dbo].[tblCollegeMaster]  WITH CHECK ADD  CONSTRAINT [FK_tblCollegeMaster_tblAccomodationMaster] FOREIGN KEY([AccomodationId])
REFERENCES [dbo].[tblAccomodationMaster] ([AccomodationId])
GO
ALTER TABLE [dbo].[tblCollegeMaster] CHECK CONSTRAINT [FK_tblCollegeMaster_tblAccomodationMaster]
GO
/****** Object:  ForeignKey [FK_tblCollegeMaster_tblUniversityMaster]    Script Date: 04/28/2014 21:18:55 ******/
ALTER TABLE [dbo].[tblCollegeMaster]  WITH CHECK ADD  CONSTRAINT [FK_tblCollegeMaster_tblUniversityMaster] FOREIGN KEY([UniversityId])
REFERENCES [dbo].[tblUniversityMaster] ([UniversityId])
GO
ALTER TABLE [dbo].[tblCollegeMaster] CHECK CONSTRAINT [FK_tblCollegeMaster_tblUniversityMaster]
GO
/****** Object:  ForeignKey [FK_tblCollegeMaster_tblZoneMaster]    Script Date: 04/28/2014 21:18:55 ******/
ALTER TABLE [dbo].[tblCollegeMaster]  WITH CHECK ADD  CONSTRAINT [FK_tblCollegeMaster_tblZoneMaster] FOREIGN KEY([ZoneId])
REFERENCES [dbo].[tblZoneMaster] ([ZoneId])
GO
ALTER TABLE [dbo].[tblCollegeMaster] CHECK CONSTRAINT [FK_tblCollegeMaster_tblZoneMaster]
GO
