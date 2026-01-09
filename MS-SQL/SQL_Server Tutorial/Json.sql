DECLARE @JSONData AS NVARCHAR(4000)
SET @JSONData = N'{
    "EmployeeInfo":{
        "FirstName":"Jignesh",
        "LastName":"Trivedi",
        "Code":"CCEEDD",
        "Addresses":[
            { "Address":"Test 0", "City":"Gandhinagar", "State":"Gujarat"},
            { "Address":"Test 1", "City":"Gandhinagar", "State":"Gujarat"}
        ]
    }
}'
--ISJSON
SELECT  ISJSON(@JSONData)

--JSON_VALUE
SELECT JSON_VALUE(@JSONData,'$.EmployeeInfo.FirstName') as 'beforeUpdate'
SELECT JSON_VALUE(@JSONData,'$.EmployeeInfo.Addresses[1].Address')  as 'beforeUpdate'

--JSON_QUERY
SELECT JSON_QUERY(@JSONData,'$.EmployeeInfo.Addresses')
SELECT JSON_QUERY(@JSONData,'$.EmployeeInfo.Addresses[1]')

--JSON_MODIFY 
SET @JSONData = JSON_MODIFY(@JSONData,'$.EmployeeInfo.FirstName', 'Rakesh')
SET @JSONData = JSON_MODIFY(@JSONData,'$.EmployeeInfo.Addresses[0].Address', 'Test Address')
SELECT JSON_VALUE(@JSONData,'$.EmployeeInfo.FirstName') as 'AfterUpdate'
SELECT JSON_VALUE(@JSONData,'$.EmployeeInfo.Addresses[0].Address') as 'AfterUpdate'

--Inserting a Value
SET @JSONData = JSON_MODIFY(@JSONData,'$.EmployeeInfo.MiddleName ', 'G')
SELECT JSON_QUERY(@JSONData,'$.EmployeeInfo') as 'Inserting'

--Appending a Value
SET @JSONData = JSON_MODIFY(@JSONData,'append $.EmployeeInfo.Addresses', JSON_QUERY('{"Address":"Test 2", "City":"Bhavnagar", "State":"Gujarat"}','$'))
SELECT JSON_QUERY(@JSONData,'$.EmployeeInfo.Addresses') as 'Appending'

--Multiple updates
SET @JSONData = JSON_MODIFY(JSON_MODIFY(@JSONData,'$.EmployeeInfo.FirstName', 'Ramesh'),'$.EmployeeInfo.LastName','Oza')
SELECT JSON_QUERY(@JSONData,'$.EmployeeInfo') as 'Multiple'

--Deleting existing value
SET @JSONData = JSON_MODIFY(@JSONData,'$.EmployeeInfo.FirstName', NULL)
SELECT JSON_QUERY(@JSONData,'$.EmployeeInfo') as 'Deleting'

--Renaming Key ["FirstName" to "ForeName."]
SET @JSONData = JSON_MODIFY(JSON_MODIFY(@JSONData,'$.EmployeeInfo.ForeName',JSON_VALUE(@JSONData,'$.EmployeeInfo.LastName')),'$.EmployeeInfo.LastName', NULL)
SELECT JSON_QUERY(@JSONData,'$.EmployeeInfo') as 'rename'

---------------------------FOR JSON-------------------------------------
select * from tbl_employee for json auto
select * from tbl_employee for json path 

select * from tbl_employee for json auto, root('abc')
select * from tbl_employee for json path , root('abc')

----------------------------------------------------------------------------------------------------------------------------------
/*CREATE TABLE [dbo].[Addresses](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [EmployeeId] [int] NULL,
    [Address] [varchar](250) NULL,
    [City] [varchar](50) NULL,
    [State] [varchar](50) NULL,
 CONSTRAINT [PK_Addresses] PRIMARY KEY CLUSTERED
(
    [Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
CREATE TABLE [dbo].[EmployeeInfo](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [Code] [varchar](50) NULL,
    [FirstName] [varchar](50) NULL,
    [LastName] [varchar](50) NULL,
 CONSTRAINT [PK_EmployeeInfo] PRIMARY KEY CLUSTERED
(
    [Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Addresses] ON

GO
INSERT [dbo].[Addresses] ([Id], [EmployeeId], [Address], [City], [State]) VALUES (1, 1, N'Test 0', N'Gandhinagar', N'Gujarat')
GO
INSERT [dbo].[Addresses] ([Id], [EmployeeId], [Address], [City], [State]) VALUES (2, 1, N'Test 1', N'Bhavnagar', N'Gujarat')
GO
INSERT [dbo].[Addresses] ([Id], [EmployeeId], [Address], [City], [State]) VALUES (3, 2, N'Test 2', N'Bhavnagar', N'Gujarat')
GO
INSERT [dbo].[Addresses] ([Id], [EmployeeId], [Address], [City], [State]) VALUES (4, 2, N'Test 3', N'Gandhinagar', N'Gujarat')
GO
SET IDENTITY_INSERT [dbo].[Addresses] OFF
GO
SET IDENTITY_INSERT [dbo].[EmployeeInfo] ON

GO
INSERT [dbo].[EmployeeInfo] ([Id], [Code], [FirstName], [LastName]) VALUES (1, N'ABCD', N'Jignesh', N'Trivedi')
GO
INSERT [dbo].[EmployeeInfo] ([Id], [Code], [FirstName], [LastName]) VALUES (2, N'XYZ', N'Rakesh', N'Trivedi')
GO
SET IDENTITY_INSERT [dbo].[EmployeeInfo] OFF
GO
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_EmployeeInfo] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[EmployeeInfo] ([Id])
GO
ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK_Addresses_EmployeeInfo]
GO*/
----------------------------------------------------------------------------------------------------------------------------------
--FOR JSON AUTO
SELECT * FROM [db_practice].[dbo].[EmployeeInfo] e
INNER JOIN [db_practice].[dbo].[Addresses] Addresses ON e.Id = Addresses.EmployeeId
WHERE e.Id = 1
FOR JSON AUTO, ROOT ('EmployeeInfo')

--FOR JSON PATH
SELECT Id, Code, FirstName, LastName,
    (SELECT Id, Address, City, State
    FROM [db_practice].[dbo].[Addresses] a
    WHERE a.EmployeeId = e.Id
    FOR JSON AUTO
    ) as Addresses
FROM [db_practice].[dbo].[EmployeeInfo] e
WHERE e.Id =1
FOR JSON PATH, ROOT ('EmployeeInfo')

---------------------------------------------------------OPENJSON---------------------------------------------------
DECLARE @JSONData1 AS NVARCHAR(4000)
SET @JSONData1 = N'{
        "FirstName":"Jignesh",
        "LastName":"Trivedi",
        "Code":"CCEEDD",
        "Addresses":[
            { "Address":"Test 0", "City":"Gandhinagar", "State":"Gujarat"},
            { "Address":"Test 1", "City":"Gandhinagar", "State":"Gujarat"}
        ]
    }'

SELECT * FROM OPENJSON(@JSONData1)

--OPENJSON with a Pre-defined Schema
--1)
DECLARE @JSONData2 AS NVARCHAR(4000)
SET @JSONData2 = N'{
        "FirstName":"Jignesh",
        "LastName":"Trivedi",
        "Code":"CCEEDD"
    }'

SELECT * FROM OPENJSON(@JSONData2)
WITH (FirstName VARCHAR(50),
LastName VARCHAR(50),
Code VARCHAR(50))

--2)
DECLARE @JSONData3 AS NVARCHAR(4000)
SET @JSONData3 = N'{
        "FirstName":"Jignesh",
        "LastName":"Trivedi",
        "Code":"CCEEDD",
        "Addresses":[
            { "Address":"Test 0", "City":"Bhavnagar", "State":"Gujarat"},
            { "Address":"Test 1", "City":"Gandhinagar", "State":"Gujarat"}
        ]
    }'

SELECT
FirstName, LastName, Address, City, State
FROM OPENJSON(@JSONData3)
WITH (FirstName VARCHAR(50),
LastName VARCHAR(50),
Code VARCHAR(50),
Addresses NVARCHAR(max) as json
) as B
cross apply openjson (B.Addresses)
with
(
    Address VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50)
)
