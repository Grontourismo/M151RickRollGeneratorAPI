USE [master]
GO
/****** Object:  Database [RickRollGeneratorM151]    Script Date: 07.11.2021 15:32:34 ******/
CREATE DATABASE [RickRollGeneratorM151]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RickRollGeneratorM151', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS01\MSSQL\DATA\RickRollGeneratorM151.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'RickRollGeneratorM151_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS01\MSSQL\DATA\RickRollGeneratorM151_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [RickRollGeneratorM151] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RickRollGeneratorM151].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RickRollGeneratorM151] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RickRollGeneratorM151] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RickRollGeneratorM151] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RickRollGeneratorM151] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RickRollGeneratorM151] SET ARITHABORT OFF 
GO
ALTER DATABASE [RickRollGeneratorM151] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RickRollGeneratorM151] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RickRollGeneratorM151] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RickRollGeneratorM151] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RickRollGeneratorM151] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RickRollGeneratorM151] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RickRollGeneratorM151] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RickRollGeneratorM151] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RickRollGeneratorM151] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RickRollGeneratorM151] SET  DISABLE_BROKER 
GO
ALTER DATABASE [RickRollGeneratorM151] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RickRollGeneratorM151] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RickRollGeneratorM151] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RickRollGeneratorM151] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RickRollGeneratorM151] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RickRollGeneratorM151] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RickRollGeneratorM151] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RickRollGeneratorM151] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [RickRollGeneratorM151] SET  MULTI_USER 
GO
ALTER DATABASE [RickRollGeneratorM151] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RickRollGeneratorM151] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RickRollGeneratorM151] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RickRollGeneratorM151] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [RickRollGeneratorM151] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [RickRollGeneratorM151] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [RickRollGeneratorM151] SET QUERY_STORE = OFF
GO
USE [RickRollGeneratorM151]
GO
/****** Object:  Table [dbo].[CountryStats]    Script Date: 07.11.2021 15:32:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CountryStats](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[country] [varchar](255) NOT NULL,
	[count] [int] NOT NULL,
	[prank_fk] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pranks]    Script Date: 07.11.2021 15:32:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pranks](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[uid] [varchar](255) NOT NULL,
	[title] [varchar](45) NOT NULL,
	[description] [varchar](155) NOT NULL,
	[imageURL] [varchar](255) NOT NULL,
	[createDate] [datetime] NOT NULL,
	[active] [tinyint] NOT NULL,
	[count] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CountryStats]  WITH CHECK ADD FOREIGN KEY([prank_fk])
REFERENCES [dbo].[Pranks] ([id])
GO
/****** Object:  StoredProcedure [dbo].[IncreaseCount]    Script Date: 07.11.2021 15:32:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Procedure [dbo].[IncreaseCount] 

@UID varchar(255)

AS
BEGIN

	UPDATE Pranks

	SET count = count + 1

	WHERE uid = @UID;

END
GO
/****** Object:  StoredProcedure [dbo].[IncreaseCountryCount]    Script Date: 07.11.2021 15:32:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[IncreaseCountryCount]

@prank_id int,
@country varchar(255),
@count int

AS

BEGIN

	if (select COUNT(country) from CountryStats where country = @country AND prank_fk = @prank_id) = 0 
	BEGIN
		Insert into CountryStats (country, count, prank_fk) VALUES (@country, @count, @prank_id)
	END
	else
	BEGIN
		Update CountryStats
		Set count = count + 1
		Where prank_fk = @prank_id AND country = @country
	END
END
GO
USE [master]
GO
ALTER DATABASE [RickRollGeneratorM151] SET  READ_WRITE 
GO
