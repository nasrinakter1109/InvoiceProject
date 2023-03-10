USE [master]
GO
/****** Object:  Database [InvoiceDb]    Script Date: 7/13/2021 1:26:28 AM ******/
CREATE DATABASE [InvoiceDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'InvoiceDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\InvoiceDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'InvoiceDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\InvoiceDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [InvoiceDb] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [InvoiceDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [InvoiceDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [InvoiceDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [InvoiceDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [InvoiceDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [InvoiceDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [InvoiceDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [InvoiceDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [InvoiceDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [InvoiceDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [InvoiceDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [InvoiceDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [InvoiceDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [InvoiceDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [InvoiceDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [InvoiceDb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [InvoiceDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [InvoiceDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [InvoiceDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [InvoiceDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [InvoiceDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [InvoiceDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [InvoiceDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [InvoiceDb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [InvoiceDb] SET  MULTI_USER 
GO
ALTER DATABASE [InvoiceDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [InvoiceDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [InvoiceDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [InvoiceDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [InvoiceDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [InvoiceDb] SET QUERY_STORE = OFF
GO
USE [InvoiceDb]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 7/13/2021 1:26:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [nvarchar](50) NULL,
	[CustomerType] [nvarchar](50) NULL,
	[EntyDate] [date] NULL,
	[Address] [nvarchar](50) NULL,
	[Mobile] [nvarchar](15) NULL,
	[PhoneNo] [nvarchar](15) NULL,
	[Fax] [nvarchar](20) NULL,
	[Email] [nvarchar](20) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoice]    Script Date: 7/13/2021 1:26:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NULL,
	[InvoiceDate] [date] NULL,
	[InvoiceNo] [int] NULL,
	[OutletId] [int] NULL,
	[SalesTypeId] [int] NULL,
	[PaymentTypeId] [int] NULL,
	[InvoiceTypeId] [int] NULL,
	[RefNo] [nvarchar](50) NULL,
	[InvoiceAmount] [decimal](18, 2) NULL,
	[ShippingAmount] [decimal](18, 0) NULL,
	[DiscountRate] [decimal](18, 0) NULL,
	[DiscountAmt] [decimal](18, 2) NULL,
	[TotalVat] [decimal](18, 2) NULL,
	[LessAmt] [decimal](18, 0) NULL,
	[CashAmt] [decimal](18, 0) NULL,
	[AdvAmt] [decimal](18, 0) NULL,
	[ChgeAmt] [decimal](18, 2) NULL,
	[Total] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InvoiceDetails]    Script Date: 7/13/2021 1:26:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NULL,
	[InvoiceNo] [int] NULL,
	[Quantity] [decimal](18, 0) NULL,
	[UnitId] [int] NULL,
	[Price] [decimal](18, 0) NULL,
	[Amount] [decimal](18, 0) NULL,
	[DiscountRate] [decimal](18, 0) NULL,
	[DiscountAmount] [decimal](18, 2) NULL,
	[Vat] [decimal](18, 0) NULL,
	[VatAmount] [decimal](18, 2) NULL,
	[SubTotal] [decimal](18, 2) NULL,
 CONSTRAINT [PK_InvoiceDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 7/13/2021 1:26:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[WarehouseId] [int] NULL,
	[Description] [nvarchar](50) NULL,
	[Quantity] [int] NULL,
	[ProductName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Unit]    Script Date: 7/13/2021 1:26:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Unit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UnitName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Unit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Warehouse]    Script Date: 7/13/2021 1:26:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Warehouse](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[WarehouseName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Warehouse] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([Id], [CustomerName], [CustomerType], [EntyDate], [Address], [Mobile], [PhoneNo], [Fax], [Email]) VALUES (1, N'Customer1', N'Regular Customer', CAST(N'2021-07-01' AS Date), N'Test Address', N'01929298674', N'01929298674', N'Test Fax', N'Test mail')
SET IDENTITY_INSERT [dbo].[Customer] OFF
SET IDENTITY_INSERT [dbo].[Invoice] ON 

INSERT [dbo].[Invoice] ([Id], [CustomerId], [InvoiceDate], [InvoiceNo], [OutletId], [SalesTypeId], [PaymentTypeId], [InvoiceTypeId], [RefNo], [InvoiceAmount], [ShippingAmount], [DiscountRate], [DiscountAmt], [TotalVat], [LessAmt], [CashAmt], [AdvAmt], [ChgeAmt], [Total]) VALUES (1, 1, CAST(N'2021-07-01' AS Date), 1, 1, 1, 1, 1, N'1', CAST(445.92 AS Decimal(18, 2)), CAST(10 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(4.56 AS Decimal(18, 2)), CAST(4.42 AS Decimal(18, 2)), CAST(10 AS Decimal(18, 0)), CAST(400 AS Decimal(18, 0)), CAST(350 AS Decimal(18, 0)), CAST(10.00 AS Decimal(18, 2)), CAST(385.77 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Invoice] OFF
SET IDENTITY_INSERT [dbo].[InvoiceDetails] ON 

INSERT [dbo].[InvoiceDetails] ([Id], [ProductId], [InvoiceNo], [Quantity], [UnitId], [Price], [Amount], [DiscountRate], [DiscountAmount], [Vat], [VatAmount], [SubTotal]) VALUES (1, 2, 1, CAST(20 AS Decimal(18, 0)), 1, CAST(20 AS Decimal(18, 0)), CAST(400 AS Decimal(18, 0)), CAST(2 AS Decimal(18, 0)), CAST(8.00 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(3.92 AS Decimal(18, 2)), CAST(395.92 AS Decimal(18, 2)))
INSERT [dbo].[InvoiceDetails] ([Id], [ProductId], [InvoiceNo], [Quantity], [UnitId], [Price], [Amount], [DiscountRate], [DiscountAmount], [Vat], [VatAmount], [SubTotal]) VALUES (2, 4, 1, CAST(5 AS Decimal(18, 0)), 2, CAST(10 AS Decimal(18, 0)), CAST(50 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(0.50 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(0.50 AS Decimal(18, 2)), CAST(50.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[InvoiceDetails] OFF
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([Id], [WarehouseId], [Description], [Quantity], [ProductName]) VALUES (2, 1, N'ok update', 20, N'product1 update')
INSERT [dbo].[Product] ([Id], [WarehouseId], [Description], [Quantity], [ProductName]) VALUES (4, 1, N'Test Description Update', 5, N'Test Product Update')
INSERT [dbo].[Product] ([Id], [WarehouseId], [Description], [Quantity], [ProductName]) VALUES (5, NULL, NULL, 0, N'test')
INSERT [dbo].[Product] ([Id], [WarehouseId], [Description], [Quantity], [ProductName]) VALUES (6, NULL, NULL, 0, N'TTest')
INSERT [dbo].[Product] ([Id], [WarehouseId], [Description], [Quantity], [ProductName]) VALUES (7, 1, NULL, 0, N'ghg')
SET IDENTITY_INSERT [dbo].[Product] OFF
SET IDENTITY_INSERT [dbo].[Unit] ON 

INSERT [dbo].[Unit] ([Id], [UnitName]) VALUES (1, N'Kg')
INSERT [dbo].[Unit] ([Id], [UnitName]) VALUES (2, N'gm')
INSERT [dbo].[Unit] ([Id], [UnitName]) VALUES (3, N'Oz')
INSERT [dbo].[Unit] ([Id], [UnitName]) VALUES (4, N'lbs')
SET IDENTITY_INSERT [dbo].[Unit] OFF
SET IDENTITY_INSERT [dbo].[Warehouse] ON 

INSERT [dbo].[Warehouse] ([Id], [WarehouseName]) VALUES (1, N'M/s Ripon Petumery')
SET IDENTITY_INSERT [dbo].[Warehouse] OFF
/****** Object:  StoredProcedure [dbo].[SP_CustomerSave]    Script Date: 7/13/2021 1:26:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

					CREATE PROC [dbo].[SP_CustomerSave] (
					        @Id As [int]  ,
							@CustomerName As [nvarchar](50) ,
							@CustomerType As [nvarchar](50) ,
							@EntyDate As [date] ,
							@Address As [nvarchar](50) ,
							@Mobile As [nvarchar](15) ,
							@PhoneNo As [nvarchar](15) ,
							@Fax As [nvarchar](20) ,
							@Email As [nvarchar](20) )
					AS
					BEGIN
					  IF (@ID=0)
					  INSERT INTO Customer (CustomerName,CustomerType,EntyDate,Address,Mobile,PhoneNo,Fax,Email)
					  VALUES (@CustomerName,@CustomerType,@EntyDate,@Address,@Mobile,@PhoneNo,@Fax,@Email)
						
					  ELSE 
					  UPDATE Customer Set
							CustomerName=@CustomerName ,
								CustomerType=@CustomerType ,
								EntyDate=@EntyDate ,
								Address=@Address ,
								Mobile=@Mobile ,
								PhoneNo=@PhoneNo ,
								Fax=@Fax ,
								Email=@Email 
							WHERE Id=@Id

					END
GO
/****** Object:  StoredProcedure [dbo].[SP_ProductSave]    Script Date: 7/13/2021 1:26:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

					Create PROC [dbo].[SP_ProductSave] (
					        @Id As [int]  ,
							@ProductName As [nvarchar](50) ,
							@Description As [nvarchar](50) ,
							@WarehouseId As [int] ,
							@Quantity As [int] )
					AS
					BEGIN
					  IF (@ID=0)
					  INSERT INTO Product(ProductName,Description,WarehouseId,Quantity)
					  VALUES (@ProductName,@Description,@WarehouseId,@Quantity)
						
					  ELSE 
					  UPDATE Product Set
							ProductName=@ProductName ,
								Description=@Description ,
								WarehouseId=@WarehouseId ,
								Quantity=@Quantity 
							WHERE Id=@Id

					END
GO
/****** Object:  StoredProcedure [dbo].[usp_Invoice_Detail_Save]    Script Date: 7/13/2021 1:26:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

					Create PROC [dbo].[usp_Invoice_Detail_Save] (
					                @Id AS [int] ,
									@ProductId AS [int] ,
									@InvoiceNo AS [int] ,
									@Quantity AS [decimal](18, 0) ,
									@UnitId AS [int] ,
									@Price AS [decimal](18, 0) ,
									@Amount AS [decimal](18, 0) ,
									@DiscountRate AS [decimal](18, 0) ,
									@DiscountAmount AS [decimal](18, 2) ,
									@Vat AS [decimal](18, 0) ,
									@VatAmount AS [decimal](18, 2) ,
									@SubTotal AS [decimal](18, 2)  )
					AS
					BEGIN
					  IF (@ID=0)
					  INSERT INTO InvoiceDetails (ProductId,InvoiceNo,Quantity,UnitId,Price,Amount,DiscountRate,DiscountAmount,Vat,VatAmount,SubTotal)
					  VALUES (@ProductId,@InvoiceNo,@Quantity,@UnitId,@Price,@Amount,@DiscountRate,@DiscountAmount,@Vat,@VatAmount,@SubTotal)
						
					  ELSE 
					  UPDATE InvoiceDetails Set
									ProductId=@ProductId,
									InvoiceNo=@InvoiceNo,
									Quantity=@Quantity,
									UnitId=@UnitId,
									Price=@Price,
									Amount=@Amount,
									DiscountRate=@DiscountRate,
									DiscountAmount=@DiscountAmount,
									Vat=@Vat,
									VatAmount=@VatAmount,
									SubTotal=@SubTotal
							WHERE Id=@Id

					END
GO
/****** Object:  StoredProcedure [dbo].[usp_Invoice_Save]    Script Date: 7/13/2021 1:26:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

					Create PROC [dbo].[usp_Invoice_Save] (
					            @Id [int] ,
								@CustomerId [int] ,
								@InvoiceDate [date] ,
								@InvoiceNo [int] ,
								@OutletId [int] ,
								@SalesTypeId [int] ,
								@PaymentTypeId [int] ,
								@InvoiceTypeId [int] ,
								@RefNo [nvarchar](50) ,
								@InvoiceAmount [decimal](18, 2) ,
								@ShippingAmount [decimal](18, 0) ,
								@DiscountRate [decimal](18, 0) ,
								@DiscountAmt [decimal](18, 2) ,
								@TotalVat [decimal](18, 2) ,
								@LessAmt [decimal](18, 0) ,
								@CashAmt [decimal](18, 0) ,
								@AdvAmt [decimal](18, 0) ,
								@ChgeAmt [decimal](18, 2) ,
								@Total [decimal](18, 2) )
					AS
					BEGIN
					  IF (@ID=0)
					  INSERT INTO Invoice ( CustomerId,	InvoiceDate,InvoiceNo,OutletId,SalesTypeId,PaymentTypeId,InvoiceTypeId,RefNo,InvoiceAmount,ShippingAmount,DiscountRate,DiscountAmt,TotalVat,LessAmt,CashAmt,AdvAmt,ChgeAmt,Total)
					  VALUES (@CustomerId,@InvoiceDate,@InvoiceNo,@OutletId,@SalesTypeId,@PaymentTypeId,@InvoiceTypeId,@RefNo,@InvoiceAmount,@ShippingAmount,@DiscountRate,@DiscountAmt,@TotalVat,@LessAmt,@CashAmt,@AdvAmt,@ChgeAmt,@Total)
						
					  ELSE 
					  UPDATE Invoice Set
								CustomerId=@CustomerId,
								InvoiceDate=@InvoiceDate,
								InvoiceNo=@InvoiceNo,
								OutletId=@OutletId,
								SalesTypeId=@SalesTypeId,
								PaymentTypeId=@PaymentTypeId,
								InvoiceTypeId=@InvoiceTypeId,
								RefNo=@RefNo,
								InvoiceAmount=@InvoiceAmount,
								ShippingAmount=@ShippingAmount,
								DiscountRate=@DiscountRate,
								DiscountAmt=@DiscountAmt,
								TotalVat=@TotalVat,
								LessAmt=@LessAmt,
								CashAmt=@CashAmt,
								AdvAmt=@AdvAmt,
								ChgeAmt=@ChgeAmt,
								Total=@Total
							WHERE Id=@Id

					END
GO
USE [master]
GO
ALTER DATABASE [InvoiceDb] SET  READ_WRITE 
GO
