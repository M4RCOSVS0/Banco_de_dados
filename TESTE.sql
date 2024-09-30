<EVENT_INSTANCE><EventType>CREATE_TABLE</EventType><PostTime>2024-09-23T10:20:31.317</PostTime><SPID>69</SPID><ServerName>Notebook-Marcos</ServerName><LoginName>NOTEBOOK-MARCOS\Marcos</LoginName><UserName>dbo</UserName><DatabaseName>TG09</DatabaseName><SchemaName>dbo</SchemaName><ObjectName>TB_LOG_AUDITORIA</ObjectName><ObjectType>TABLE</ObjectType><TSQLCommand><SetOptions ANSI_NULLS="ON" ANSI_NULL_DEFAULT="ON" ANSI_PADDING="ON" QUOTED_IDENTIFIER="ON" ENCRYPTED="FALSE"/><CommandText>CREATE TABLE TB_LOG_AUDITORIA&#x0D;
(&#x0D;
id_log      int not null primary key identity (1,1),&#x0D;
dt_log      datetime,&#x0D;
nm_login    varchar(30),&#x0D;
nm_usuario  varchar(30),&#x0D;
banco       nvarchar(100),&#x0D;
esquema     nvarchar(100),&#x0D;
nm_objeto   nvarchar(100),&#x0D;
tipo_objeto nvarchar(100),&#x0D;
evento      nvarchar(100),&#x0D;
comando     nvarchar(2000)&#x0D;
)</CommandText></TSQLCommand></EVENT_INSTANCE>
[2024-09-23 10:20:31] completed in 39 ms
