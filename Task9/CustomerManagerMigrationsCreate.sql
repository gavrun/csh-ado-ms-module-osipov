SET DEADLOCK_PRIORITY -10
go
SELECT target_data
									FROM sys.dm_xe_session_targets xet WITH(nolock)
									JOIN sys.dm_xe_sessions xes WITH(nolock)
									ON xes.address = xet.event_session_address
									WHERE xes.name = 'telemetry_xevents'
									AND xet.target_name = 'ring_buffer'
go
SET DEADLOCK_PRIORITY -10
go
if not exists (select * from sys.dm_xe_sessions where name = 'telemetry_xevents')
	alter event session telemetry_xevents on server state=start
go
SET DEADLOCK_PRIORITY -10
go
SELECT target_data
									FROM sys.dm_xe_session_targets xet WITH(nolock)
									JOIN sys.dm_xe_sessions xes WITH(nolock)
									ON xes.address = xet.event_session_address
									WHERE xes.name = 'telemetry_xevents'
									AND xet.target_name = 'ring_buffer'
go
SET DEADLOCK_PRIORITY -10
go
if not exists (select * from sys.dm_xe_sessions where name = 'telemetry_xevents')
	alter event session telemetry_xevents on server state=start
go
SET LOCK_TIMEOUT 10000
go
DECLARE @edition sysname;
SET @edition = cast(SERVERPROPERTY(N'EDITION') as sysname);
SELECT case when @edition = N'SQL Azure' then 2 else 1 end as 'DatabaseEngineType',
SERVERPROPERTY('EngineEdition') AS DatabaseEngineEdition,
SERVERPROPERTY('ProductVersion') AS ProductVersion,
@@MICROSOFTVERSION AS MicrosoftVersion;
select host_platform from sys.dm_os_host_info
if @edition = N'SQL Azure' 
  select 'TCP' as ConnectionProtocol
else
  exec ('select CONVERT(nvarchar(40),CONNECTIONPROPERTY(''net_transport'')) as ConnectionProtocol')

go
SELECT CASE WHEN has_dbaccess(N'Northwind') = 1 THEN 'true' ELSE 'false' END
go
SELECT
db.name as HasMemoryOptimizedObjects from master.sys.master_files mf join master.sys.databases db on mf.database_id = db.database_id where mf.[type] = 2
go
select cast(serverproperty('EngineEdition') as int)
go
IF db_id(N'Northwind') IS NOT NULL SELECT 1 ELSE SELECT Count(*) FROM sys.databases WHERE [name]=N'Northwind'
go

SELECT Count(*)
FROM INFORMATION_SCHEMA.TABLES AS t
WHERE t.TABLE_SCHEMA + '.' + t.TABLE_NAME IN ('dbo.Customers','dbo.Orders')
    OR t.TABLE_NAME = 'EdmMetadata'
go
SELECT 
    [GroupBy1].[A1] AS [C1]
    FROM ( SELECT 
        COUNT(1) AS [A1]
        FROM [dbo].[__MigrationHistory] AS [Extent1]
    )  AS [GroupBy1]
go
SELECT TOP (1) 
    [Extent1].[Id] AS [Id], 
    [Extent1].[ModelHash] AS [ModelHash]
    FROM [dbo].[EdmMetadata] AS [Extent1]
    ORDER BY [Extent1].[Id] DESC
go
SET DEADLOCK_PRIORITY -10
go
SELECT target_data
									FROM sys.dm_xe_session_targets xet WITH(nolock)
									JOIN sys.dm_xe_sessions xes WITH(nolock)
									ON xes.address = xet.event_session_address
									WHERE xes.name = 'telemetry_xevents'
									AND xet.target_name = 'ring_buffer'
go
SET DEADLOCK_PRIORITY -10
go
if not exists (select * from sys.dm_xe_sessions where name = 'telemetry_xevents')
	alter event session telemetry_xevents on server state=start
go
select cast(serverproperty('EngineEdition') as int)
go
IF db_id(N'CustomerManager') IS NOT NULL SELECT 1 ELSE SELECT Count(*) FROM sys.databases WHERE [name]=N'CustomerManager'
go
create database [CustomerManager]
go
if serverproperty('EngineEdition') <> 5 execute sp_executesql N'alter database [CustomerManager] set read_committed_snapshot on'
go
CREATE TABLE [dbo].[Customers] (
    [CustomerId] [int] NOT NULL IDENTITY,
    [Name] [nvarchar](max),
    [Email] [nvarchar](max),
    [Age] [int] NOT NULL,
    [Photo] [varbinary](max),
    CONSTRAINT [PK_dbo.Customers] PRIMARY KEY ([CustomerId])
)
go
CREATE TABLE [dbo].[Orders] (
    [OrderId] [int] NOT NULL IDENTITY,
    [ProductName] [nvarchar](max),
    [Description] [nvarchar](max),
    [Quantity] [int] NOT NULL,
    [PurchaseDate] [datetime] NOT NULL,
    [Customer_CustomerId] [int],
    CONSTRAINT [PK_dbo.Orders] PRIMARY KEY ([OrderId])
)
go
CREATE INDEX [IX_Customer_CustomerId] ON [dbo].[Orders]([Customer_CustomerId])
go
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_dbo.Orders_dbo.Customers_Customer_CustomerId] FOREIGN KEY ([Customer_CustomerId]) REFERENCES [dbo].[Customers] ([CustomerId])
go
CREATE TABLE [dbo].[__MigrationHistory] (
    [MigrationId] [nvarchar](150) NOT NULL,
    [ContextKey] [nvarchar](300) NOT NULL,
    [Model] [varbinary](max) NOT NULL,
    [ProductVersion] [nvarchar](32) NOT NULL,
    CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY ([MigrationId], [ContextKey])
)
go
INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
VALUES (N'202503231659005_InitialCreate', N'CodeFirst.SampleContext',  0x1F8B0800000000000400CD59D96EE336147D2FD07F10F4D41619CBC9BCB4813D83344B6174B234CE0CFA16D0D2B54394A254920A6C14FDB23EF493FA0BBDA4B55094644B4E33530C30B0B81CDE9D8737FFFCF5F7E4FD3A66DE330849133EF58F4763DF031E2611E5ABA99FA9E59BEFFDF7EFBEFE6A7219C56BEF53B1EEAD5E873BB99CFA4F4AA5A74120C32788891CC53414894C966A14267140A22438198F7F088E8F0340081FB13C6F729F714563301FF8799EF010529511769D44C0643E8E337383EADD9018644A4298FAE7B8E28A0AA97CEF8C518202CC812D7D8F709E28A250BCD38F12E64A247C354F7180B0874D0AB86E4998845CECD36A795F0DC6275A83A0DA5840859954493C10F0F86D6E92C0DD7E9061FDD26468B44B34AEDA68AD8DE1D066E60810BEE71E767ACE845E68D97554AC3EF2CAB1A3D2F51821FA1FCE654C6502A61C3225083BF2EEB205A3E1CFB079487E033EE51963B6542817CED50670E84E242908B5B987A523EB2CF2BDA0BE3F7001CAED2D7BB75ACDB87A7BE27B37280C59302883C0B2C05C25027E020E822888EE885220D087B3088C191B523867EAFF8BD330EA306F7CEF9AAC3F005FA9A7A98F3F7DEF8AAE212A4672093E728A69869B94C860DF219731A1ECD54F395BC13EBBED06B87B4A545240FC4839119B7E623AB037E499AE8C779C036E458471E87BF7C0CCB47CA2E9B6008CCCD46315E9572289EF13566C2A671E1F885801568F87A4757A9E642274449A04554AED4C3483D52FCBCCD22F9362E6E843F2ABDCF8B9920B3FA32C549F25C72E408682A6DB12FCCA67FD92915CFF17A51B46EA13917081B62D90F4EF07AACDB50FAC33C9AA1C7A499A1579D491664516F649B3332993901A49EC40ACA4A82B76C9236FB7485BE796EAA08331D3688AB985A74FFDEF1AB6EA842C8B490559D9A68E3A1E8D8E5D7D2DCD9A7505599122145327577A4EE294811E85B56A2932487BF23A23F3287495D0A873508E9FB19E56766F28D1B0441DA4A8C80D84DCB2CE764B6107C38A296B517BD4B9256EAFC74BA92B8183DE20858F2D10CB746E0DAD6BD812DDA55B2B961B6C696E4187830E3E3CB926698A05C9E2C7F98837CFC9F19BF970FA186F318250B6B0C852DAF224ACE86405CEAC75B36105220BA20BCE79143796D583B823B68AB3DC386DBAAC08BA6287FE9DEF6AF059777B65BE2BD428C61BC928072D7E6E6E356F13C288D84141CF1396C57C1FADDD85B6BDF86C9CED487F849C39DA10F9507F0CC30B6D0433D07F7F4E0B6D847CA88931091C9FB83E0F1A4E7712D08DA25E31965785C3026C5BEA864757C7BE2E3396ECCB36640797DBE90E9B54D59C624FF4C7AB11271BAF36D11FAF22473658353A40D31A41AAA95A9BF9FC6158BF255A62D1BA0E3B43CE5AD32BB4F415D716538DABAE698E836ADDE3AEA2A72D544A3358D0FC62EF29E8B0CCD92919DE5C11354C742635C32ED9F54003B844A119250DBEE02E2963B4E40D0E3F98E477F580A65A71796F97F81E9AE19946E6E2DE4805F1482F18CD7F67E78C6256540BAE09A74B906AFB32F54FC6C7274E83EEFFD32C0BA48C58CF8ED917EF60516DE5BDCFE8812F47FB41CD9F89AE85E29B98ACBFB5910637A65E8464359F8CCA2F693DA11C0BD37DEA21C9C0DECE176CB7BC4A24B474585EE4C6962ECA8BF0DC4EC941B1D1D22789F0B7EAD527E9C8D0C78E546D3CCB673C82F5D4FFC3EC3FF566BF3EB6401C79C6D9A7DED8FBF3B0783DB84952271A839B18CD97F3210D16CC16103A8409C3FB4E2A81375E8373DD09CA439A12E64ADEA40143AAB2B66909EDCE5C400A5C27574DC32107EE6141E5014E71D8679181CDA3E6F3BC5F7368676F68CB12309916BAF46E23B6BB35D2DA3AEAEE1CB581B7376F5EBDABE41AA3DE1BD8DB4A6AF69F5EA76DD4A47B1846D65F5A3198255D55109ACC72086B0154AE99F1655204B52351B1C4A98CD7A00896557226145D9250E17408529A0EFA27C23243171610CDF86DA6D24CA1CA102F58ED45A7F361D7F9A637569779726B6E1BF95FA88062527D33DCF21F33CAA252EEABE6CDD005A1132DBF9FB52F95BEA7579B12E926E13D8172F395F5E101E2942198BCE573F20C87C8F651C20758917053B0F66E90FD8EA89B7D7241C94A9058E618D57EFCC4188EE2F5BB7F0118D43C2670200000 , N'6.5.1')

go
SET LOCK_TIMEOUT 10000
go
DECLARE @edition sysname;
SET @edition = cast(SERVERPROPERTY(N'EDITION') as sysname);
SELECT case when @edition = N'SQL Azure' then 2 else 1 end as 'DatabaseEngineType',
SERVERPROPERTY('EngineEdition') AS DatabaseEngineEdition,
SERVERPROPERTY('ProductVersion') AS ProductVersion,
@@MICROSOFTVERSION AS MicrosoftVersion;
select host_platform from sys.dm_os_host_info
if @edition = N'SQL Azure' 
  select 'TCP' as ConnectionProtocol
else
  exec ('select CONVERT(nvarchar(40),CONNECTIONPROPERTY(''net_transport'')) as ConnectionProtocol')

go
SELECT CASE WHEN has_dbaccess(N'CustomerManager') = 1 THEN 'true' ELSE 'false' END
go
SELECT
db.name as HasMemoryOptimizedObjects from master.sys.master_files mf join master.sys.databases db on mf.database_id = db.database_id where mf.[type] = 2
go
SET LOCK_TIMEOUT 10000
go
DECLARE @edition sysname;
SET @edition = cast(SERVERPROPERTY(N'EDITION') as sysname);
SELECT case when @edition = N'SQL Azure' then 2 else 1 end as 'DatabaseEngineType',
SERVERPROPERTY('EngineEdition') AS DatabaseEngineEdition,
SERVERPROPERTY('ProductVersion') AS ProductVersion,
@@MICROSOFTVERSION AS MicrosoftVersion;
select host_platform from sys.dm_os_host_info
if @edition = N'SQL Azure' 
  select 'TCP' as ConnectionProtocol
else
  exec ('select CONVERT(nvarchar(40),CONNECTIONPROPERTY(''net_transport'')) as ConnectionProtocol')

go
IF OBJECT_ID (N'[sys].[database_query_store_options]') IS NOT NULL BEGIN SELECT ISNULL(actual_state, -2) FROM sys.database_query_store_options; IF EXISTS (SELECT TOP(1) 1 FROM sys.query_store_runtime_stats) SELECT 1 ELSE SELECT 0; END
go
SET LOCK_TIMEOUT 10000
go
DECLARE @edition sysname;
SET @edition = cast(SERVERPROPERTY(N'EDITION') as sysname);
SELECT case when @edition = N'SQL Azure' then 2 else 1 end as 'DatabaseEngineType',
SERVERPROPERTY('EngineEdition') AS DatabaseEngineEdition,
SERVERPROPERTY('ProductVersion') AS ProductVersion,
@@MICROSOFTVERSION AS MicrosoftVersion;
select host_platform from sys.dm_os_host_info
if @edition = N'SQL Azure' 
  select 'TCP' as ConnectionProtocol
else
  exec ('select CONVERT(nvarchar(40),CONNECTIONPROPERTY(''net_transport'')) as ConnectionProtocol')

go
use [CustomerManager]
go
SET LOCK_TIMEOUT 10000
go
DECLARE @edition sysname;
SET @edition = cast(SERVERPROPERTY(N'EDITION') as sysname);
SELECT case when @edition = N'SQL Azure' then 2 else 1 end as 'DatabaseEngineType',
SERVERPROPERTY('EngineEdition') AS DatabaseEngineEdition,
SERVERPROPERTY('ProductVersion') AS ProductVersion,
@@MICROSOFTVERSION AS MicrosoftVersion;
select host_platform from sys.dm_os_host_info
if @edition = N'SQL Azure' 
  select 'TCP' as ConnectionProtocol
else
  exec ('select CONVERT(nvarchar(40),CONNECTIONPROPERTY(''net_transport'')) as ConnectionProtocol')

go
use [CustomerManager]
go
SET LOCK_TIMEOUT 10000
go
DECLARE @edition sysname;
SET @edition = cast(SERVERPROPERTY(N'EDITION') as sysname);
SELECT case when @edition = N'SQL Azure' then 2 else 1 end as 'DatabaseEngineType',
SERVERPROPERTY('EngineEdition') AS DatabaseEngineEdition,
SERVERPROPERTY('ProductVersion') AS ProductVersion,
@@MICROSOFTVERSION AS MicrosoftVersion;
select host_platform from sys.dm_os_host_info
if @edition = N'SQL Azure' 
  select 'TCP' as ConnectionProtocol
else
  exec ('select CONVERT(nvarchar(40),CONNECTIONPROPERTY(''net_transport'')) as ConnectionProtocol')

go
use [CustomerManager]
go
SET LOCK_TIMEOUT 10000
go
DECLARE @edition sysname;
SET @edition = cast(SERVERPROPERTY(N'EDITION') as sysname);
SELECT case when @edition = N'SQL Azure' then 2 else 1 end as 'DatabaseEngineType',
SERVERPROPERTY('EngineEdition') AS DatabaseEngineEdition,
SERVERPROPERTY('ProductVersion') AS ProductVersion,
@@MICROSOFTVERSION AS MicrosoftVersion;
select host_platform from sys.dm_os_host_info
if @edition = N'SQL Azure' 
  select 'TCP' as ConnectionProtocol
else
  exec ('select CONVERT(nvarchar(40),CONNECTIONPROPERTY(''net_transport'')) as ConnectionProtocol')

go
use [CustomerManager]
go
SET LOCK_TIMEOUT 10000
go
DECLARE @edition sysname;
SET @edition = cast(SERVERPROPERTY(N'EDITION') as sysname);
SELECT case when @edition = N'SQL Azure' then 2 else 1 end as 'DatabaseEngineType',
SERVERPROPERTY('EngineEdition') AS DatabaseEngineEdition,
SERVERPROPERTY('ProductVersion') AS ProductVersion,
@@MICROSOFTVERSION AS MicrosoftVersion;
select host_platform from sys.dm_os_host_info
if @edition = N'SQL Azure' 
  select 'TCP' as ConnectionProtocol
else
  exec ('select CONVERT(nvarchar(40),CONNECTIONPROPERTY(''net_transport'')) as ConnectionProtocol')

go
use [CustomerManager]
go
SET LOCK_TIMEOUT 10000
go
DECLARE @edition sysname;
SET @edition = cast(SERVERPROPERTY(N'EDITION') as sysname);
SELECT case when @edition = N'SQL Azure' then 2 else 1 end as 'DatabaseEngineType',
SERVERPROPERTY('EngineEdition') AS DatabaseEngineEdition,
SERVERPROPERTY('ProductVersion') AS ProductVersion,
@@MICROSOFTVERSION AS MicrosoftVersion;
select host_platform from sys.dm_os_host_info
if @edition = N'SQL Azure' 
  select 'TCP' as ConnectionProtocol
else
  exec ('select CONVERT(nvarchar(40),CONNECTIONPROPERTY(''net_transport'')) as ConnectionProtocol')

go
use [CustomerManager]
go
DECLARE @edition sysname;
SET @edition = cast(SERVERPROPERTY(N'EDITION') as sysname);
SELECT case when @edition = N'SQL Azure' then 2 else 1 end as 'DatabaseEngineType',
SERVERPROPERTY('EngineEdition') AS DatabaseEngineEdition,
SERVERPROPERTY('ProductVersion') AS ProductVersion,
@@MICROSOFTVERSION AS MicrosoftVersion;
select host_platform from sys.dm_os_host_info
if @edition = N'SQL Azure' 
  select 'TCP' as ConnectionProtocol
else
  exec ('select CONVERT(nvarchar(40),CONNECTIONPROPERTY(''net_transport'')) as ConnectionProtocol')

go
SET DEADLOCK_PRIORITY -10
go
SELECT target_data
									FROM sys.dm_xe_session_targets xet WITH(nolock)
									JOIN sys.dm_xe_sessions xes WITH(nolock)
									ON xes.address = xet.event_session_address
									WHERE xes.name = 'telemetry_xevents'
									AND xet.target_name = 'ring_buffer'
go
SET DEADLOCK_PRIORITY -10
go
if not exists (select * from sys.dm_xe_sessions where name = 'telemetry_xevents')
	alter event session telemetry_xevents on server state=start
go
