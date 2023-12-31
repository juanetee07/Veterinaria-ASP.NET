USE [master]
GO
/****** Object:  Database [Veterinaria]    Script Date: 21/11/2023 17:12:11 ******/
CREATE DATABASE [Veterinaria]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Veterinaria', FILENAME = N'C:\SQLData\Data\Veterinaria.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Veterinaria_log', FILENAME = N'C:\SQLData\Data\Veterinaria_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Veterinaria] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Veterinaria].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Veterinaria] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Veterinaria] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Veterinaria] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Veterinaria] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Veterinaria] SET ARITHABORT OFF 
GO
ALTER DATABASE [Veterinaria] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Veterinaria] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Veterinaria] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Veterinaria] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Veterinaria] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Veterinaria] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Veterinaria] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Veterinaria] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Veterinaria] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Veterinaria] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Veterinaria] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Veterinaria] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Veterinaria] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Veterinaria] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Veterinaria] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Veterinaria] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Veterinaria] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Veterinaria] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Veterinaria] SET  MULTI_USER 
GO
ALTER DATABASE [Veterinaria] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Veterinaria] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Veterinaria] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Veterinaria] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Veterinaria] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Veterinaria] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Veterinaria] SET QUERY_STORE = ON
GO
ALTER DATABASE [Veterinaria] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Veterinaria]
GO
/****** Object:  Table [dbo].[Animales]    Script Date: 21/11/2023 17:12:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Animales](
	[Id_Animal] [int] NOT NULL,
	[Nombre] [varchar](250) NULL,
	[FechaBaja] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Animal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Razas]    Script Date: 21/11/2023 17:12:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Razas](
	[Id_Raza] [int] NOT NULL,
	[Nombre] [varchar](250) NULL,
	[Id_Animal] [int] NULL,
	[FechaBaja] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Raza] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mascotas]    Script Date: 21/11/2023 17:12:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mascotas](
	[Id_Mascota] [int] NOT NULL,
	[Nombre] [varchar](250) NULL,
	[Apodo] [varchar](250) NULL,
	[NombreDueño] [varchar](250) NULL,
	[Id_Raza] [int] NULL,
	[FechaBaja] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Mascota] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VistaMascotasConRazaYAnimal]    Script Date: 21/11/2023 17:12:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VistaMascotasConRazaYAnimal] AS
SELECT
    M.Id_Mascota,
    M.Nombre AS NombreMascota,
    M.Apodo,
    M.NombreDueño,
    R.Nombre AS Raza,
    A.Nombre AS Animal
FROM
    Mascotas M
    INNER JOIN Razas R ON M.Id_Raza = R.Id_Raza
    INNER JOIN Animales A ON R.Id_Animal = A.Id_Animal;

GO
/****** Object:  View [dbo].[VistaMascotasActivas]    Script Date: 21/11/2023 17:12:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VistaMascotasActivas] AS
SELECT *
FROM Mascotas
WHERE FechaBaja IS NULL;
GO
/****** Object:  View [dbo].[VistaRazasPorAnimal]    Script Date: 21/11/2023 17:12:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VistaRazasPorAnimal] AS
SELECT
    A.Nombre AS Animal,
    R.Nombre AS Raza
FROM
    Animales A
    INNER JOIN Razas R ON A.Id_Animal = R.Id_Animal;
GO
/****** Object:  View [dbo].[VistaMascotasConRazaYAnimalIncluyendoBaja]    Script Date: 21/11/2023 17:12:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VistaMascotasConRazaYAnimalIncluyendoBaja] AS
SELECT
    M.Id_Mascota,
    M.Nombre AS NombreMascota,
    M.Apodo,
    M.NombreDueño,
    R.Nombre AS Raza,
    A.Nombre AS Animal,
    M.FechaBaja AS FechaBajaMascota,
    R.FechaBaja AS FechaBajaRaza,
    A.FechaBaja AS FechaBajaAnimal
FROM
    Mascotas M
    INNER JOIN Razas R ON M.Id_Raza = R.Id_Raza
    INNER JOIN Animales A ON R.Id_Animal = A.Id_Animal;
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 21/11/2023 17:12:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[Id_Cliente] [int] NOT NULL,
	[Nombre] [varchar](50) NULL,
	[Apellido] [varchar](50) NULL,
	[NúmeroCelular] [int] NULL,
	[CorreoElectronico] [varchar](50) NULL,
 CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED 
(
	[Id_Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Mascotas]  WITH CHECK ADD FOREIGN KEY([Id_Raza])
REFERENCES [dbo].[Razas] ([Id_Raza])
GO
ALTER TABLE [dbo].[Razas]  WITH CHECK ADD FOREIGN KEY([Id_Animal])
REFERENCES [dbo].[Animales] ([Id_Animal])
GO
/****** Object:  StoredProcedure [dbo].[ActualizarAnimal]    Script Date: 21/11/2023 17:12:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarAnimal]
    @Id_Animal INT,
    @Nombre VARCHAR(250),
    @FechaBaja DATETIME
AS
BEGIN
    UPDATE Animales
    SET Nombre = @Nombre, FechaBaja = @FechaBaja
    WHERE Id_Animal = @Id_Animal;
END;
GO
/****** Object:  StoredProcedure [dbo].[ActualizarMascota]    Script Date: 21/11/2023 17:12:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarMascota]
    @Id_Mascota INT,
    @Nombre VARCHAR(250),
    @Apodo VARCHAR(250),
    @NombreDueño VARCHAR(250),
    @Id_Raza INT,
    @FechaBaja DATETIME
AS
BEGIN
    UPDATE Mascotas
    SET Nombre = @Nombre, Apodo = @Apodo, NombreDueño = @NombreDueño, Id_Raza = @Id_Raza, FechaBaja = @FechaBaja
    WHERE Id_Mascota = @Id_Mascota;
END;
GO
/****** Object:  StoredProcedure [dbo].[ActualizarRaza]    Script Date: 21/11/2023 17:12:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarRaza]
    @Id_Raza INT,
    @Nombre VARCHAR(250),
    @Id_Animal INT,
    @FechaBaja DATETIME
AS
BEGIN
    UPDATE Razas
    SET Nombre = @Nombre, Id_Animal = @Id_Animal, FechaBaja = @FechaBaja
    WHERE Id_Raza = @Id_Raza;
END;
GO
/****** Object:  StoredProcedure [dbo].[EliminarAnimal]    Script Date: 21/11/2023 17:12:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarAnimal]
    @Id_Animal INT
AS
BEGIN
    DELETE FROM Animales WHERE Id_Animal = @Id_Animal;
END;
GO
/****** Object:  StoredProcedure [dbo].[EliminarMascota]    Script Date: 21/11/2023 17:12:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarMascota]
    @Id_Mascota INT
AS
BEGIN
    DELETE FROM Mascotas WHERE Id_Mascota = @Id_Mascota;
END;
GO
/****** Object:  StoredProcedure [dbo].[EliminarRaza]    Script Date: 21/11/2023 17:12:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarRaza]
    @Id_Raza INT
AS
BEGIN
    DELETE FROM Razas WHERE Id_Raza = @Id_Raza;
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarAnimal]    Script Date: 21/11/2023 17:12:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertarAnimal]
    @Id_Animal INT,
    @Nombre VARCHAR(250),
    @FechaBaja DATETIME
AS
BEGIN
    INSERT INTO Animales VALUES (@Id_Animal, @Nombre, @FechaBaja);
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarMascota]    Script Date: 21/11/2023 17:12:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertarMascota]
    @Nombre VARCHAR(250),
    @Apodo VARCHAR(250),
    @NombreDueño VARCHAR(250),
    @Id_Raza INT
AS
BEGIN
    INSERT INTO Mascotas (Nombre, Apodo, NombreDueño, Id_Raza, FechaBaja)
    VALUES (@Nombre, @Apodo, @NombreDueño, @Id_Raza, NULL);
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarRaza]    Script Date: 21/11/2023 17:12:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertarRaza]
    @Nombre VARCHAR(250),
    @Id_Animal INT
AS
BEGIN
    INSERT INTO Razas (Nombre, Id_Animal, FechaBaja)
    VALUES (@Nombre, @Id_Animal, NULL);
END;
GO
/****** Object:  StoredProcedure [dbo].[SeleccionarAnimales]    Script Date: 21/11/2023 17:12:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SeleccionarAnimales]
AS
BEGIN
    SELECT * FROM Animales;
END;
GO
/****** Object:  StoredProcedure [dbo].[SeleccionarMascotas]    Script Date: 21/11/2023 17:12:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SeleccionarMascotas]
AS
BEGIN
    SELECT * FROM Mascotas;
END;
GO
/****** Object:  StoredProcedure [dbo].[SeleccionarRazas]    Script Date: 21/11/2023 17:12:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SeleccionarRazas]
AS
BEGIN
    SELECT * FROM Razas;
END;
GO
USE [master]
GO
ALTER DATABASE [Veterinaria] SET  READ_WRITE 
GO
