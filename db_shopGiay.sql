USE [master]
GO

CREATE DATABASE [db_ShopGiay]
GO
USE [db_ShopGiay]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [nvarchar](100) NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_detail](
	[order_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[price] [decimal](18, 0) NULL,
	[quantity] [int] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC,
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[order_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[status] [int] NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[category_id] [int] NOT NULL,
	[product_name] [nvarchar](100) NOT NULL,
	[product_height] [nvarchar](100) NOT NULL,
	[product_type] [nvarchar](100) NOT NULL,
	[product_description] [ntext] NOT NULL,
	[product_price] [decimal](18, 0) NOT NULL,
	[product_image] [varchar](50) NULL,
	[product_amount] [int] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[email] [nvarchar](100) NOT NULL,
	[phone_number] [nvarchar](11) NULL,
	[password] [nvarchar](200) NOT NULL,
	[full_name] [nvarchar](50) NULL,
	[address] [nvarchar](100) NULL,
	[role] [int] NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[is_active] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- trigger for categories

CREATE TRIGGER trg_insert_category ON [categories]
FOR INSERT
AS 
  UPDATE [categories]
	SET created_at = GETDATE(), updated_at = GETDATE()
	from [categories] inner join inserted i
	on [categories].category_id = i.category_id
go
create trigger trg_category_update on [categories]
for update 
as
	begin
	  update [categories]
		set updated_at = getDate()
		from [categories] inner join deleted d
		on [categories].category_id = d.category_id;
	end


-- trigger for users
go
CREATE TRIGGER trg_insert_user ON [users]
FOR INSERT
AS 
  UPDATE [users]
	SET created_at = GETDATE(), updated_at = GETDATE()
	from [users] inner join inserted i
	on [users].user_id = i.user_id
go
create trigger trg_user_update on [users]
for update 
as
	begin
	  update [users]
		set updated_at = getDate()
		from [users] inner join deleted d
		on [users].user_id = d.user_id;
	end

		-- trigger for products
go
CREATE TRIGGER trg_insert_products ON [products]
FOR INSERT
AS 
  UPDATE [products]
	SET created_at = GETDATE(), updated_at = GETDATE()
	from [products] inner join inserted i
	on [products].product_id = i.product_id
go
create trigger trg_product_update on [products]
for update 
as
	begin
	  update [products]
		set updated_at = getDate()
		from [products] inner join deleted d
		on [products].product_id = d.product_id;
	end

				-- trigger for orders
go
CREATE TRIGGER trg_insert_order ON [orders]
FOR INSERT
AS 
  UPDATE [orders]
	SET created_at = GETDATE(), updated_at = GETDATE()
	from [orders] inner join inserted i
	on [orders].order_id = i.order_id
go
create trigger trg_order_update on [orders]
for update 
as
	begin
	  update [orders]
		set updated_at = getDate()
		from [orders] inner join deleted d
		on [orders].order_id = d.order_id;
	end

					-- trigger for orders_detail
go
CREATE TRIGGER trg_insert_orderd ON [order_detail]
FOR INSERT
AS 
  UPDATE [order_detail]
	SET created_at = GETDATE(), updated_at = GETDATE()
	from [order_detail] inner join inserted i
	on [order_detail].order_id = i.order_id and [order_detail].product_id = i.product_id
go
create trigger trg_orderd_update on [order_detail]
for update 
as
	begin
	  update [order_detail]
		set updated_at = getDate()
		from [order_detail] inner join deleted d
		on [order_detail].order_id = d.order_id and [order_detail].product_id = d.product_id;
	end

GO

SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([category_id], [category_name], [created_at], [updated_at]) VALUES (1, N'Giày Cao Gót', NULL, CAST(N'2021-09-28T22:23:11.203' AS DateTime))
INSERT [dbo].[Categories] ([category_id], [category_name], [created_at], [updated_at]) VALUES (2, N'Giày Sandals', NULL, CAST(N'2021-09-28T22:22:59.927' AS DateTime))
INSERT [dbo].[Categories] ([category_id], [category_name], [created_at], [updated_at]) VALUES (3, N'Giày Sneaker', NULL, CAST(N'2021-09-28T22:22:53.987' AS DateTime))
INSERT [dbo].[Categories] ([category_id], [category_name], [created_at], [updated_at]) VALUES (4, N'Giày Boots', NULL, CAST(N'2021-09-28T22:23:27.047' AS DateTime))
INSERT [dbo].[Categories] ([category_id], [category_name], [created_at], [updated_at]) VALUES (5, N'Giày Da Thật', NULL, CAST(N'2021-09-28T22:23:41.237' AS DateTime))
INSERT [dbo].[Categories] ([category_id], [category_name], [created_at], [updated_at]) VALUES (6, N'Giày Lười', NULL, CAST(N'2021-09-28T22:23:49.590' AS DateTime))
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
INSERT [dbo].[Order_detail] ([order_id], [product_id], [price], [quantity], [created_at], [updated_at]) VALUES (1, 1, CAST(20000 AS Decimal(18, 0)), 2, CAST(N'2021-09-24T07:54:48.090' AS DateTime), CAST(N'2021-09-24T07:54:48.093' AS DateTime))
INSERT [dbo].[Order_detail] ([order_id], [product_id], [price], [quantity], [created_at], [updated_at]) VALUES (1, 2, CAST(20000 AS Decimal(18, 0)), 1, CAST(N'2021-09-24T07:54:48.097' AS DateTime), CAST(N'2021-09-24T07:54:48.097' AS DateTime))
INSERT [dbo].[Order_detail] ([order_id], [product_id], [price], [quantity], [created_at], [updated_at]) VALUES (1, 3, CAST(200000 AS Decimal(18, 0)), 1, CAST(N'2021-09-24T07:54:48.097' AS DateTime), CAST(N'2021-09-24T07:54:48.097' AS DateTime))
INSERT [dbo].[Order_detail] ([order_id], [product_id], [price], [quantity], [created_at], [updated_at]) VALUES (1, 4, CAST(200000 AS Decimal(18, 0)), 3, CAST(N'2021-09-24T07:54:48.097' AS DateTime), CAST(N'2021-09-24T07:54:48.097' AS DateTime))
INSERT [dbo].[Order_detail] ([order_id], [product_id], [price], [quantity], [created_at], [updated_at]) VALUES (2, 5, CAST(20000 AS Decimal(18, 0)), 1, CAST(N'2021-09-24T10:47:08.010' AS DateTime), CAST(N'2021-09-24T10:47:08.020' AS DateTime))
INSERT [dbo].[Order_detail] ([order_id], [product_id], [price], [quantity], [created_at], [updated_at]) VALUES (2, 6, CAST(200000 AS Decimal(18, 0)), 3, CAST(N'2021-09-24T10:47:08.020' AS DateTime), CAST(N'2021-09-24T10:47:08.020' AS DateTime))
INSERT [dbo].[Order_detail] ([order_id], [product_id], [price], [quantity], [created_at], [updated_at]) VALUES (2, 7, CAST(200000 AS Decimal(18, 0)), 1, CAST(N'2021-09-24T10:47:08.023' AS DateTime), CAST(N'2021-09-24T10:47:08.023' AS DateTime))
INSERT [dbo].[Order_detail] ([order_id], [product_id], [price], [quantity], [created_at], [updated_at]) VALUES (3, 8, CAST(20000 AS Decimal(18, 0)), 1, CAST(N'2021-09-24T10:50:35.453' AS DateTime), CAST(N'2021-09-24T10:50:35.457' AS DateTime))
INSERT [dbo].[Order_detail] ([order_id], [product_id], [price], [quantity], [created_at], [updated_at]) VALUES (3, 9, CAST(20000 AS Decimal(18, 0)), 7, CAST(N'2021-09-24T10:50:35.457' AS DateTime), CAST(N'2021-09-24T10:50:35.457' AS DateTime))
INSERT [dbo].[Order_detail] ([order_id], [product_id], [price], [quantity], [created_at], [updated_at]) VALUES (3, 10, CAST(200000 AS Decimal(18, 0)), 1, CAST(N'2021-09-24T10:50:35.457' AS DateTime), CAST(N'2021-09-24T10:50:35.457' AS DateTime))
INSERT [dbo].[Order_detail] ([order_id], [product_id], [price], [quantity], [created_at], [updated_at]) VALUES (3, 11, CAST(200000 AS Decimal(18, 0)), 33, CAST(N'2021-09-24T10:50:35.457' AS DateTime), CAST(N'2021-09-24T10:50:35.457' AS DateTime))
INSERT [dbo].[Order_detail] ([order_id], [product_id], [price], [quantity], [created_at], [updated_at]) VALUES (3, 12, CAST(200000 AS Decimal(18, 0)), 25, CAST(N'2021-09-24T10:50:35.460' AS DateTime), CAST(N'2021-09-24T10:50:35.460' AS DateTime))
INSERT [dbo].[Order_detail] ([order_id], [product_id], [price], [quantity], [created_at], [updated_at]) VALUES (4, 13, CAST(200000 AS Decimal(18, 0)), 1, CAST(N'2021-09-24T13:20:56.603' AS DateTime), CAST(N'2021-09-24T13:20:56.603' AS DateTime))
INSERT [dbo].[Order_detail] ([order_id], [product_id], [price], [quantity], [created_at], [updated_at]) VALUES (4, 14, CAST(200000 AS Decimal(18, 0)), 1, CAST(N'2021-09-24T13:20:56.607' AS DateTime), CAST(N'2021-09-24T13:20:56.607' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([order_id], [user_id], [status], [created_at], [updated_at]) VALUES (1, 2, 1, CAST(N'2021-09-24T07:54:48.030' AS DateTime), CAST(N'2021-09-24T07:54:48.040' AS DateTime))
INSERT [dbo].[Orders] ([order_id], [user_id], [status], [created_at], [updated_at]) VALUES (2, 2, 1, CAST(N'2021-09-24T10:47:07.987' AS DateTime), CAST(N'2021-09-24T10:47:07.990' AS DateTime))
INSERT [dbo].[Orders] ([order_id], [user_id], [status], [created_at], [updated_at]) VALUES (3, 2, 3, CAST(N'2021-09-24T10:50:35.423' AS DateTime), CAST(N'2021-09-24T11:51:03.097' AS DateTime))
INSERT [dbo].[Orders] ([order_id], [user_id], [status], [created_at], [updated_at]) VALUES (4, 2, 1, CAST(N'2021-09-24T13:20:56.587' AS DateTime), CAST(N'2021-09-24T13:20:56.590' AS DateTime))
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (1, 1, N'Giày Sandal Ankle Strap Da Nubuck Quai Vân Da Rắn', N' Gót đặc biệt -  8 cm', N' Hở mũi (mũi vuông) - Da nhân tạo & Microfiber', N' Đi làm, đi tiệc, đi chơi', CAST(595000 AS Decimal(18, 0)), N'1-Giay-Sandal-Quai-Van-Da-Ran.jpg', 45, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (2, 1, N'Giày Bít Mũi Nhọn Ankle Strap Đính Dây Kim Loại Bạc', N' Gót nhọn -  8 cm', N'Bít mũi nhọn -  Da nhân tạo', N' Đi làm, đi tiệc, đi chơi', CAST(645000 AS Decimal(18, 0)), N'2-giay-ankle-strap-dinh-day-kim-loai-bac.jpg', 100, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (3, 1, N'Giày Bít Mũi Nhọn Da Nubuck', N' Gót loe -  6.5 cm', N' Bít mũi nhọn -  Da nhân tạo', N' Đi làm, đi tiệc, đi chơi', CAST(545000 AS Decimal(18, 0)), N'3-giay-bit-mui-nubuck-mau-do.jpg', 120, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (4, 1, N'Giày Ankle Strap Quai Ngang Xếp Ly', N' Gót loe -  8 cm', N' Hở mũi (mũi vuông) -  Vải & Satin', N' Đi làm, đi tiệc, đi chơi', CAST(545000 AS Decimal(18, 0)), N'4-giay-ankle-strap-quai-ngang-mau-hong-dam.jpg', 60, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (5, 1, N'Giày Bít Mũi Nhọn Gót Metallic', N'Gót loe - gót 7.5 cm', N'Bít mũi nhọn - Da nhân tạo', N' Đi làm, đi tiệc, đi chơi', CAST(545000 AS Decimal(18, 0)), N'4-giay-ankle-strap-quai-ngang-mau-hong-dam.jpg', 65, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (6, 1, N'Giày Đế Xuồng Quai Ngang Phối Mắt Xích', N' Đế xuồng -  10 cm', N' Bít mũi tròn -  Da nhân tạo & Cói', N' Đi làm, đi tiệc, đi chơi', CAST(625000 AS Decimal(18, 0)), N'6-giay-quai-ngang-mat-xich-mau-nau-sang.jpg', 55, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (7, 1, N'Giày Ankle Strap Vân Da Kỳ Đà', N' Gót loe - 7 cm', N' Bít mũi nhọn - Da nhân tạo & Microfiber', N' Đi làm, đi tiệc, đi chơi', CAST(545000 AS Decimal(18, 0)), N'7-Giay-Ankle-Strap Van-Da-Ky-Da.jpg', 50, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (8, 1, N'Giày Sandal Ankle Strap Gót Trụ Metallic', N' Gót loe -  8 cm', N' Hở mũi (mũi vuông) -  Da nhân tạo', N' Đi làm, đi tiệc, đi chơi', CAST(545000 AS Decimal(18, 0)), N'8-Giay-Sandal-Ankle-Strap-Got Tru-Metallic.jpg', 30, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (9, 1, N'Giày Sandal Quai Đôi Thanh Lịch', N' Gót dạng khối -  6.5 cm', N'Hở mũi (mũi vuông) -  Da nhân tạo', N' Đi làm, đi tiệc, đi chơi', CAST(545000 AS Decimal(18, 0)), N'9-Giay-Sandal-Quai Doi-Thanh-Lich.jpg', 70, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (10, 2, N'Giày Sandal Quai Mảnh Phối Kim Tuyến Metallic', N' Gót đặc biệt -  9 cm', N'Hở mũi (mũi vuông) - Chất liệu đặc biệt', N' Đi làm, đi tiệc, đi chơi', CAST(645000 AS Decimal(18, 0)), N'10-giay-sandal-quai-manh-phoi-kim-tuyen.jpg', 120, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (11, 2, N'Giày Sandal Quai Ngang Vân Cá Sấu', N'Gót dạng khối - gót 2.5 cm', N'Hở mũi (mũi vuông) - Da nhân tạo', N'Đi chơi, đi làm, đi học', CAST(525000 AS Decimal(18, 0)), N'11-giay-sandal-quai-ngang-van-ca-sau.jpg', 110, NULL, CAST(N'2021-09-29T09:35:11.513' AS DateTime))
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (12, 2, N'Giày Multi-Strap Vân Da Kỳ Đà', N' Gót dạng khối - gót 2.5 cm', N' Hở mũi (mũi vuông) - Da nhân tạo', N'Đi làm, đi chơi, đi học', CAST(420000 AS Decimal(18, 0)), N'12-giay-multi-strap-van-da-ky-da.jpg', 140, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (13, 2, N'Giày Ankle Strap Mũi Vuông Quai Kim Loại', N'Gót nhọn - gót 9 cm', N'Hở mũi (mũi vuông) - Da nhân tạo', N' Đi làm, đi tiệc, đi chơi', CAST(436000 AS Decimal(18, 0)), N'13-giay-ankle-strap-mui-vuong-quai-kim-loai.jpg', 200, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (14, 2, N'Giày Sandal Họa Tiết Vân Rắn', N'Gót đặc biệt - gót 8 cm', N'Hở mũi - Da nhân tạo', N' Đi làm, đi tiệc, đi chơi', CAST(545000 AS Decimal(18, 0)), N'14-giay-sandal-hoa-tiet-van-ran.jpg', 40, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (15, 2, N'Giày Sandal Gót Hình Khối Đa Giác Phối Da Rắn', N'Gót đặc biệt - gót 5 cm', N'Hở mũi (mũi thuôn không nhọn) - Da nhân tạo', N' Đi làm, đi tiệc, đi chơi', CAST(545000 AS Decimal(18, 0)), N'15-giay-sandal-got-da-ran-hong-dam.jpg', 200, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (16, 3, N'Giày Sneaker Viền Chỉ Nổi Thời Trang', N' Đế bánh mì - 2.5 cm', N' Bít mũi tròn - Da nhân tạo & Plastic', N' Đi chơi, đi làm, đi học', CAST(795000 AS Decimal(18, 0)), N'16-giay-sneaker-vien-chi-noi-thoi-trang-trang.jpg', 230, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (17, 3, N'Giày Sneaker Neon Light 3', N'Đế bánh mì - 2.5 cm', N'Bít mũi tròn - Da nhân tạo & Plastic', N' Đi chơi, đi làm, đi học', CAST(795000 AS Decimal(18, 0)), N'24-Giay-Sneaker-Neon-Light.jpg', 400, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (18, 3, N'Giày Sneaker Da Nubuck', N'Đế bánh mì - 2.5 cm', N'Bít mũi tròn - Da nhân tạo', N' Đi chơi, đi làm, đi học', CAST(745000 AS Decimal(18, 0)), N'18-giay-sneaker-da-nubuck-mau-xam-nhat.jpg', 230, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (19, 3, N'Giày Sneaker Gót Đính Metallic Phối Da Hologram', N' Đế bằng - 2.5 cm', N' Bít mũi tròn - Da nhân tạo', N' Đi chơi, đi làm, đi học', CAST(795000 AS Decimal(18, 0)), N'19-giay-sneaker-got-metallici-da-hologram.jpg', 210, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (20, 3, N'Giày Sneaker Vải Knit Cổ Co Giãn', N'Đế bánh mì - 3 cm', N'Bít mũi tròn - Vải & Plastic', N'Đi chơi, đi làm, đi học', CAST(540000 AS Decimal(18, 0)), N'20-giay-sneaker-co-mid-mau-den.jpg', 300, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (21, 3, N'Giày Sneaker Viền Chỉ Nối Cổ Co Giãn', N'Đế bánh mì - 6.5 cm', N'Bít mũi tròn - Da nhân tạo & Plastic', N' Đi chơi, đi làm, đi học', CAST(745000 AS Decimal(18, 0)), N'21-giay-sneaker-vien-chi-co-gian-mau-be.jpg', 120, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (22, 3, N'Giày Sneaker Phối Metallic Đan Lưới', N' Đế bánh mì - 2 cm', N' Bít mũi tròn - Da nhân tạo', N' Đi chơi, đi làm, đi học', CAST(397500 AS Decimal(18, 0)), N'22-Giay-Sneaker-Phoi-Metallic-Dan-Luoi.jpg', 190, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (23, 3, N'Giày Sneaker Neon Light 2', N'Đế bánh mì - 2.5 cm', N' Bít mũi tròn - Da nhân tạo', N' Đi chơi, đi làm, đi học', CAST(372500 AS Decimal(18, 0)), N'23-giay-sneaker-neon-light-2-kem.jpg', 340, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (24, 3, N'Giày Sneaker Neon Light', N'Đế bánh mì - 2.5 cm', N'Bít mũi tròn - Da nhân tạo', N' Đi chơi, đi làm, đi học', CAST(372500 AS Decimal(18, 0)), N'24-Giay-Sneaker-Neon-Light.jpg', 400, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (25, 3, N'Giày Sneaker Phối Metallic', N'Đế bánh mì - 2.5 cm', N' Bít mũi tròn - Da nhân tạo', N' Đi chơi, đi làm, đi học', CAST(347500 AS Decimal(18, 0)), N'25- Giay-Sneaker-Phoi-Metallic.jpg', 80, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (26, 3, N'Giày Sneaker Chần Bông Đính Kim Loại', N'Đế bánh mì - 2.5 cm', N' Bít mũi tròn - Da nhân tạo', N' Đi chơi, đi làm, đi học', CAST(362500 AS Decimal(18, 0)), N'26-Giay-Sneaker-Chan Bong-Kim-Loai.jpg', 100, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (27, 3, N'Giày Sneaker Vải Tweed ', N' Đế bằng ', N'Bít mũi tròn - Da nhân tạo & Vải Tweed', N' Đi chơi, đi làm, đi học', CAST(347500 AS Decimal(18, 0)), N'27-Giay-Sneaker-Vai-Tweed.jpg', 300, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (28, 3, N'Giày Sneaker Họa Tiết Nhiệt Đới', N'Đế bánh mì - 2.5 cm', N'Bít mũi tròn - Da tổng hợp', N' Đi làm, đi học, đi chơi', CAST(337500 AS Decimal(18, 0)), N'28-Giay-Sneaker-Nhiet-Doi.jpg', 230, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (29, 3, N'Giày Sneaker In Họa Tiết', N'Đế bánh mì', N'Bít mũi tròn - Da tổng hợp', N' Đi làm, đi học, đi chơi', CAST(347500 AS Decimal(18, 0)), N'29-Giay-Sneaker-In-Hoa-Tiet.jpg', 240, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (30, 3, N'Giày Sneaker SNK - Màu Xanh Da Trời', N'Đế bằng - 4.5 cm', N'Bít mũi tròn - Denim', N' Đi học, đi chơi', CAST(322500 AS Decimal(18, 0)), N'30-Sneaker-SNK-Xanh-Da-Troi.jpg', 220, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (31, 4, N'Boots Đế Bằng Buộc Dây', N' Đế bằng - 2.5 cm', N' Bít mũi tròn - Da nhân tạo', N'Đi chơi, đi làm, dạo phố', CAST(497500 AS Decimal(18, 0)), N'31-Boots-de-Bang-Buoc-day.jpg', 310, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (32, 4, N'Chelsea Boots Quai Cài Cá Tính', N' Đế bệt - 2.5 cm', N'Bít mũi tròn - Da nhân tạo & Microfiber', N'Đi chơi, đi làm, dạo phố', CAST(497500 AS Decimal(18, 0)), N'32-Chelsea-Boots-Quai-Cai.jpg', 100, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (33, 4, N'Boots Cao Gót Phối Vải Mesh', N' Gót nhọn - 8.5 cm', N'Bít mũi nhọn - Da nhân tạo', N' Đi chơi, đi làm, dạo phố', CAST(497500 AS Decimal(18, 0)), N'33-Boots-Cao-Got-Vai-Mesh.jpg', 410, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (34, 4, N'Giày Boots Mũi Nhọn', N'Gót đặc biệt - 7.5 cm', N' Bít mũi nhọn - Da tổng hợp', N' Đi chơi, đi làm, dạo phố', CAST(397500 AS Decimal(18, 0)), N'34-Giay-Boots-Mui-Nhon.jpg', 290, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (35, 4, N'Giày Boots Gót Vuông', N'Gót dạng khối - 7 cm', N'Bít mũi nhọn - Microfiber', N' Đi chơi, đi làm, dạo phố', CAST(447500 AS Decimal(18, 0)), N'35-Boots-Got-Vuong.jpg', 110, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (36, 4, N'Giày Boots Da Lộn', N' Gót dạng khối - 8 cm', N'Bít mũi vuông - Da tổng hợp', N' Đi chơi, đi làm, dạo phố', CAST(497500 AS Decimal(18, 0)), N'36-Boots-Da-Lon.jpg', 300, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (37, 4, N'Giày Boots Phối Len', N'Đế bệt ', N'Bít mũi tròn - Da tổng hợp', N' Đi chơi, đi làm, dạo phố', CAST(497500 AS Decimal(18, 0)), N'37-Boots-Phoi-Len.jpg', 260, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (38, 4, N'Giày Boots Phối Belt', N' Đế bệt', N' Bít mũi tròn - Da tổng hợp & Microfiber', N'Đi chơi, đi làm, dạo phố', CAST(397500 AS Decimal(18, 0)), N'38-Boots-Phoi-Belt.jpg', 50, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (39, 5, N'Giày Sandal Quai Ngang Phối Khóa', N'Gót to dạng khối - 7 cm', N' Hở mũi - Da thật', N'Đi làm, đi tiệc, đi chơi', CAST(499500 AS Decimal(18, 0)), N'39-Sandal-Quai-Ngang-Phoi-Khoa.jpg', 200, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (40, 5, N'Giày Sandal Cao Gót Vuông', N' Gót dạng khối - 7 cm', N'Hở mũi (mũi tròn) - Da thật', N' Đi làm, đi tiệc, đi chơi', CAST(499500 AS Decimal(18, 0)), N'40-Sandal-Cao-Got-Vuong.jpg', 110, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (41, 5, N'Giày Sandal Cao Quai Đan Chéo', N'Gót dạng khối - 5.5 cm', N'Hở mũi (mũi vuông) - Da thật', N' Đi làm, đi tiệc, đi chơi', CAST(499500 AS Decimal(18, 0)), N'41-sandal-quai-dan-cheo.jpg', 70, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (42, 5, N'Giày Cao Gót SDN', N'Gót nhọn - 7 cm', N'Hở mũi - Da Thật', N' Đi làm, đi tiệc, đi chơi', CAST(499500 AS Decimal(18, 0)), N'42-Giay-Cao-Got-SDN.jpg', 40, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (43, 5, N'Giày Cao Gót SDN 0582', N' Gót vuông - 7.5 cm', N' Hở mũi -  Da thật', N' Đi làm, đi tiệc, đi chơi', CAST(499500 AS Decimal(18, 0)), N'43-Giay-Cao-Got-SDN-0582.jpg', 45, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (44, 6, N'Giày Lười Đính Nơ Thanh Lịch', N' Đế bệt - 1.5 cm', N'Bít mũi vuông - Microfiber & Da nhân tạo', N' Đi chơi, đi làm, đi học', CAST(272500 AS Decimal(18, 0)), N'44-giay-luoi-dinh-no-mau-da.jpg', 110, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (45, 6, N'Giày Lười Phối Khóa Cài', N' Đế bằng', N' Bít mũi thuôn - Da tổng hợp', N' Đi làm, đi chơi, đi học', CAST(272500 AS Decimal(18, 0)), N'45-Giay-Luoi-Phoi-Khoa-Cai.jpg', 220, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (46, 6, N'Giày Lười Satin - Màu Xanh Navy', N'Đế bệt - 2.5 cm', N'Bít mũi vuông - Satin', N' Đi làm, đi học, đi chơi, dạo phố', CAST(272500 AS Decimal(18, 0)), N'46-Giay-Luoi-Satin-Navy.jpg', 290, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (47, 6, N'Giày lười MOI 0085', N'Gót bệt', N' Bít mũi tròn - Da tổng hợp', N' Đi làm, đi học, đi chơi', CAST(262500 AS Decimal(18, 0)), N'47-Giay-luoi-MOI-0085.jpg', 100, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (48, 6, N'Giày lười MOI 0091', N'Đế bệt', N'Bít mũi tròn - Da tổng hợp (da mờ)', N' Đi học, đi chơi', CAST(212500 AS Decimal(18, 0)), N'48-Giay-luoi-MOI-0091.jpg', 275, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (49, 6, N'Giày lười MOI 0092', N'Đế bệt - 2 cm', N'Bít mũi tròn -  Da tổng hợp', N' Đi làm, đi tiệc', CAST(297500 AS Decimal(18, 0)), N'49-Giay-luoi-MOI-0092.jpg', 320, NULL, NULL)
INSERT [dbo].[Products] ([product_id], [category_id], [product_name], [product_height], [product_type], [product_description], [product_price], [product_image], [product_amount], [created_at], [updated_at]) VALUES (50, 6, N'Giày lười da thật MOI 0087', N'Đế bằng', N'Bít mũi tròn - Da thật', N' Đi làm, đi học, đi chơi, dạo phố', CAST(374500 AS Decimal(18, 0)), N'50-Giay-luoi-MOI-0087.jpg', 145, NULL, CAST(N'2021-09-29T09:30:03.247' AS DateTime))
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
INSERT [dbo].[Users] ([user_id], [email], [phone_number], [password], [full_name], [address], [role], [created_at], [updated_at], [is_active]) VALUES (1, N'nhom6admin@gmail.com', N'0866136920', N'E1-0A-DC-39-49-BA-59-AB-BE-56-E0-57-F2-0F-88-3E', N'ADMIN', N'Hà Nội', 1, CAST(N'2021-08-07T14:53:27.280' AS DateTime), CAST(N'2021-08-07T14:53:53.007' AS DateTime), 1)
go
SET IDENTITY_INSERT [dbo].[Users] OFF