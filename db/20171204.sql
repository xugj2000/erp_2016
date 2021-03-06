USE [qds126671539_db]
GO
/****** Object:  Table [dbo].[GoodsPositionSet]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GoodsPositionSet](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[StyleId] [int] NOT NULL,
	[LocalId] [varchar](50) NOT NULL,
	[AddTime] [datetime] NULL,
	[UpdateTime] [datetime] NULL,
 CONSTRAINT [PK_GoodsPositionSet] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[fun_GetStrArrayOfIndex]    Script Date: 12/04/2017 15:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create function [dbo].[fun_GetStrArrayOfIndex]

   /*
      func:       --取得有分隔符的字符串中某个子字符串 
   */
   
(

  @str varchar(1024),  --要分割的字符串

  @split varchar(10),  --分隔符号

  @index int --取第几个元素

)

returns varchar(1024)

as

begin

  declare @location int

  declare @start int

  declare @next int

  declare @seed int



  set @str=ltrim(rtrim(@str))

  set @start=1

  set @next=1

  set @seed=len(@split)

  

  set @location=charindex(@split,@str)

  while @location<>0 and @index>@next

  begin

    set @start=@location+@seed

    set @location=charindex(@split,@str,@start)

    set @next=@next+1

  end

  if @location =0 select @location =len(@str)+1

 --这儿存在两种情况：1、字符串不存在分隔符号 2、字符串中存在分隔符号，跳出while循环后，@location为0，那默认为字符串后边有一个分隔符号。

  

  return substring(@str,@start,@location-@start)

end
GO
/****** Object:  UserDefinedFunction [dbo].[fun_GetStrArrayLength]    Script Date: 12/04/2017 15:05:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fun_GetStrArrayLength]
   /*
      func:       --获取有分隔符的字符串中子字符串的数量 
   */
(

  @str varchar(1024),  --要分割的字符串

  @split varchar(10)  --分隔符号

)

returns int

as

begin

  declare @location int

  declare @start int

  declare @length int



  set @str=ltrim(rtrim(@str))

  set @location=charindex(@split,@str)

  set @length=1

  while @location<>0

  begin

    set @start=@location+1

    set @location=charindex(@split,@str,@start)

    set @length=@length+1

  end

  return @length

end
GO
/****** Object:  Table [dbo].[Direct_OrderMain]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Direct_OrderMain](
	[shopxpacid] [int] IDENTITY(1,1) NOT NULL,
	[userid] [int] NOT NULL,
	[user_name] [varchar](50) NOT NULL,
	[store_id] [int] NOT NULL,
	[warehouse_id] [int] NOT NULL,
	[seller_name] [nvarchar](100) NULL,
	[dingdan] [nvarchar](50) NOT NULL,
	[dingdan_type] [int] NULL,
	[user_type] [int] NULL,
	[order_amount] [real] NOT NULL,
	[order_plus] [real] NOT NULL,
	[freight] [real] NULL,
	[fapiao_title] [varchar](100) NULL,
	[fapiao] [int] NULL,
	[fapiao_date] [datetime] NULL,
	[wuliu_id] [int] NULL,
	[liushuihao] [varchar](100) NULL,
	[shouhuoname] [nvarchar](50) NULL,
	[province] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[xian] [varchar](50) NULL,
	[usertel] [nvarchar](50) NULL,
	[shdz] [nvarchar](100) NULL,
	[liuyan] [nvarchar](100) NULL,
	[shopxp_shfs] [int] NULL,
	[zhifufangshi] [int] NULL,
	[payment_name] [varchar](30) NOT NULL,
	[zhuangtai] [int] NULL,
	[fksj] [datetime] NULL,
	[fhsj] [datetime] NULL,
	[shsj] [datetime] NULL,
	[qxsj] [datetime] NULL,
	[add_date] [datetime] NULL,
	[AWB_No] [nvarchar](50) NULL,
	[ShippingCompany] [nvarchar](50) NOT NULL,
	[is_tiaohuan] [tinyint] NULL,
	[return_order_id] [int] NOT NULL,
	[isPay] [tinyint] NULL,
	[guide_id] [int] NOT NULL,
	[cashier_id] [int] NOT NULL,
 CONSTRAINT [PK_self_Order_Main] PRIMARY KEY CLUSTERED 
(
	[shopxpacid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [self_Order_Main_dingdan_unique] UNIQUE NONCLUSTERED 
(
	[dingdan] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单实际金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Direct_OrderMain', @level2type=N'COLUMN',@level2name=N'order_amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'优惠差价 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Direct_OrderMain', @level2type=N'COLUMN',@level2name=N'order_plus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发货公司' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Direct_OrderMain', @level2type=N'COLUMN',@level2name=N'ShippingCompany'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否调换货订单0：不是   1：是    默认值是0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Direct_OrderMain', @level2type=N'COLUMN',@level2name=N'is_tiaohuan'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0:末付款；1：已付款；' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Direct_OrderMain', @level2type=N'COLUMN',@level2name=N'isPay'
GO
EXEC sys.sp_addextendedproperty @name=N'DisAccounted', @value=N'0:末结算服务费；1:已结算服务费；' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Direct_OrderMain'
GO
EXEC sys.sp_addextendedproperty @name=N'FenxiaoType', @value=N'分销中心类型：1,市级分销中心2,县级分销中心3,社区服务店' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Direct_OrderMain'
GO
EXEC sys.sp_addextendedproperty @name=N'IsDisSale', @value=N'0:代理商进货；1:社区店销售；2:分销中心销售;' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Direct_OrderMain'
GO
/****** Object:  Table [dbo].[Direct_OrderDetail]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Direct_OrderDetail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[dingdan] [nvarchar](50) NULL,
	[supplierid] [int] NULL,
	[shopxpptid] [int] NULL,
	[style_id] [int] NULL,
	[shopxpptname] [varchar](100) NULL,
	[p_size] [varchar](100) NULL,
	[productcount] [int] NOT NULL,
	[productcount_return] [int] NOT NULL,
	[danjia] [real] NOT NULL,
	[voucher] [decimal](18, 2) NOT NULL,
	[zonger]  AS ([voucher]*[productcount]) PERSISTED,
	[unit] [varchar](50) NULL,
	[txm] [varchar](50) NULL,
	[JiFen] [money] NOT NULL,
	[huojiahao] [varchar](50) NULL,
	[StorageSortId] [int] NOT NULL,
	[area_number] [int] NOT NULL,
	[Storage_name] [varchar](50) NULL,
	[ExchangeType] [int] NULL,
	[return_detail_id] [int] NOT NULL,
	[AddTime] [datetime] NULL,
 CONSTRAINT [PK_self_Order_ProDetail] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Config_PostStyle]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Config_PostStyle](
	[songid] [int] NOT NULL,
	[subject] [nvarchar](50) NULL,
	[description] [varchar](1500) NULL,
	[dis_reg] [int] NULL,
	[dis_shop] [int] NULL,
	[dis_fenxiaojinhuo] [int] NULL,
	[dis_fenxiaosale] [int] NULL,
	[songidorder] [int] NULL,
	[warehouse_id] [int] NULL,
 CONSTRAINT [PK_Config_PostStyle] PRIMARY KEY CLUSTERED 
(
	[songid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'送货方式ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Config_PostStyle', @level2type=N'COLUMN',@level2name=N'songid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'送货方式的标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Config_PostStyle', @level2type=N'COLUMN',@level2name=N'subject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'此种方式的描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Config_PostStyle', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代理注册时是否显示' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Config_PostStyle', @level2type=N'COLUMN',@level2name=N'dis_reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否在商城显示' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Config_PostStyle', @level2type=N'COLUMN',@level2name=N'dis_shop'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否在分销中心进货显示' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Config_PostStyle', @level2type=N'COLUMN',@level2name=N'dis_fenxiaojinhuo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分销中心代下是否显示' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Config_PostStyle', @level2type=N'COLUMN',@level2name=N'dis_fenxiaosale'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'此方式的排序号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Config_PostStyle', @level2type=N'COLUMN',@level2name=N'songidorder'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'仓库id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Config_PostStyle', @level2type=N'COLUMN',@level2name=N'warehouse_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'送货方式配置表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Config_PostStyle'
GO
/****** Object:  Table [dbo].[Config_PayStyle]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Config_PayStyle](
	[ID] [int] NOT NULL,
	[songid] [int] NOT NULL,
	[subject] [nvarchar](50) NOT NULL,
	[songidorder] [int] NOT NULL,
	[DulyPay] [tinyint] NULL,
 CONSTRAINT [PK_Config_PayStyle] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付方式ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Config_PayStyle', @level2type=N'COLUMN',@level2name=N'songid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付方式的标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Config_PayStyle', @level2type=N'COLUMN',@level2name=N'subject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'此方式的排序号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Config_PayStyle', @level2type=N'COLUMN',@level2name=N'songidorder'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单下成功同时是否已付款：1,能及时扣币；0,后续付款；' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Config_PayStyle', @level2type=N'COLUMN',@level2name=N'DulyPay'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付方式配置表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Config_PayStyle'
GO
/****** Object:  Table [dbo].[Post_Freight]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Post_Freight](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[songid] [int] NULL,
	[province] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[county] [varchar](50) NULL,
	[First_Weight] [real] NOT NULL,
	[Continued_Weight] [real] NOT NULL,
	[First_Fee] [real] NOT NULL,
	[Continued_Fee] [real] NULL,
	[free_post_money] [real] NULL,
	[PostDateMin] [int] NOT NULL,
	[PostDateMax] [int] NOT NULL,
	[areaid] [int] NULL,
	[update_time] [datetime] NULL,
 CONSTRAINT [PK__Post_Freight__290D0E62] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'送货方式类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Post_Freight', @level2type=N'COLUMN',@level2name=N'songid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'运送到的省' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Post_Freight', @level2type=N'COLUMN',@level2name=N'province'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'运送到的市' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Post_Freight', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'运送到的县' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Post_Freight', @level2type=N'COLUMN',@level2name=N'county'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'起始重量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Post_Freight', @level2type=N'COLUMN',@level2name=N'First_Weight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'续重重量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Post_Freight', @level2type=N'COLUMN',@level2name=N'Continued_Weight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'此地区起始重量的运费' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Post_Freight', @level2type=N'COLUMN',@level2name=N'First_Fee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'续重价格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Post_Freight', @level2type=N'COLUMN',@level2name=N'Continued_Fee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'此地区达多少金额可免运费' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Post_Freight', @level2type=N'COLUMN',@level2name=N'free_post_money'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最短多长时间能到货' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Post_Freight', @level2type=N'COLUMN',@level2name=N'PostDateMin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最长多长时间可送到某地区' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Post_Freight', @level2type=N'COLUMN',@level2name=N'PostDateMax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Post_Freight', @level2type=N'COLUMN',@level2name=N'update_time'
GO
/****** Object:  Table [dbo].[Order_States]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Order_States](
	[id] [int] NOT NULL,
	[state] [int] NULL,
	[title] [varchar](50) NULL,
	[add_date] [datetime] NULL,
 CONSTRAINT [PK_Order_States] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LogVpn]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LogVpn](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Operator] [varchar](50) NOT NULL,
	[AddTime] [datetime] NOT NULL,
	[DoType] [nvarchar](100) NULL,
	[DoUrl] [varchar](1000) NULL,
	[DoWhat] [nvarchar](max) NULL,
	[Ip] [varchar](100) NULL,
	[objectId] [int] NOT NULL,
 CONSTRAINT [PK_LogVpn] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作人员工号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LogVpn', @level2type=N'COLUMN',@level2name=N'Operator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LogVpn', @level2type=N'COLUMN',@level2name=N'AddTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作类型(关键词，以便检索)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LogVpn', @level2type=N'COLUMN',@level2name=N'DoType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作位置URL' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LogVpn', @level2type=N'COLUMN',@level2name=N'DoUrl'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作事宜' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LogVpn', @level2type=N'COLUMN',@level2name=N'DoWhat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作人所在IP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LogVpn', @level2type=N'COLUMN',@level2name=N'Ip'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'员工业务操作日志表(暂时针对VPN操作)
by:xugj
2011-12-08' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LogVpn'
GO
/****** Object:  Table [dbo].[liushuihao]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[liushuihao](
	[id] [int] NOT NULL,
	[chukuhao] [int] NULL,
	[rukuhao] [int] NOT NULL,
	[caigouhao] [int] NOT NULL,
	[GH_jieshuanhao] [int] NULL,
	[CGhao] [int] NULL,
	[churukuhao] [int] NOT NULL,
	[wuliuprint_liushuihao] [int] NULL,
	[pandianhao] [int] NULL,
	[fenxiaoprint_liushuihao] [int] NULL,
	[zt_sale_liushuihao] [int] NOT NULL,
	[CancelSn] [int] NULL,
	[ReturnOrderId] [int] NULL,
	[WorkingSn] [int] NOT NULL,
	[GoodsSalesNumLocalFlag] [tinyint] NULL
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'仓库取消流水号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'liushuihao', @level2type=N'COLUMN',@level2name=N'CancelSn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品七日平均销售量同步到本地标识,0表，1表需回传到网上,2表回传成功等待下次更新' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'liushuihao', @level2type=N'COLUMN',@level2name=N'GoodsSalesNumLocalFlag'
GO
/****** Object:  Table [dbo].[ProductType]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductType](
	[type_id] [int] IDENTITY(1,1) NOT NULL,
	[type_name] [nvarchar](50) NOT NULL,
	[sort_order] [int] NOT NULL,
	[add_time] [datetime] NOT NULL,
	[type_remark] [nvarchar](100) NULL,
	[is_hide] [tinyint] NOT NULL,
 CONSTRAINT [PK_ProductType] PRIMARY KEY CLUSTERED 
(
	[type_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductStock]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductStock](
	[stock_id] [int] IDENTITY(1,1) NOT NULL,
	[pm_id] [int] NOT NULL,
	[pro_id] [int] NOT NULL,
	[warehouse_id] [int] NOT NULL,
	[in_nums] [decimal](18, 2) NOT NULL,
	[out_nums] [decimal](18, 2) NOT NULL,
	[kc_nums] [decimal](18, 2) NOT NULL,
	[do_nums] [decimal](18, 2) NOT NULL,
	[add_time] [datetime] NOT NULL,
	[update_time] [datetime] NOT NULL,
	[kc_flag] [tinyint] NOT NULL,
	[shelf_no] [varchar](20) NOT NULL,
	[stock_price] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_ProductStock_1] PRIMARY KEY CLUSTERED 
(
	[stock_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'过程中库存' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ProductStock', @level2type=N'COLUMN',@level2name=N'do_nums'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'本店销售价格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ProductStock', @level2type=N'COLUMN',@level2name=N'shelf_no'
GO
/****** Object:  Table [dbo].[ProductMain]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductMain](
	[pm_id] [int] IDENTITY(1,1) NOT NULL,
	[sys_date] [datetime] NOT NULL,
	[type_id] [int] NOT NULL,
	[pro_code] [varchar](20) NULL,
	[pro_name] [varchar](100) NOT NULL,
	[pro_supplierid] [int] NOT NULL,
	[spec_name_1] [nvarchar](20) NULL,
	[spec_name_2] [nvarchar](20) NULL,
	[pro_image] [varchar](50) NULL,
	[pro_pym] [varchar](20) NOT NULL,
	[pro_short] [varchar](20) NULL,
	[pro_kind] [varchar](50) NULL,
	[pro_brand] [varchar](20) NULL,
	[pro_address] [varchar](100) NULL,
	[pro_period] [int] NULL,
	[comment] [varchar](200) NULL,
	[pro_unit] [varchar](20) NOT NULL,
	[sys_del] [tinyint] NOT NULL,
	[used_flag] [tinyint] NOT NULL,
	[kc_flag] [tinyint] NOT NULL,
 CONSTRAINT [PK_ProductMain] PRIMARY KEY CLUSTERED 
(
	[pm_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[pro_id] [int] IDENTITY(1,1) NOT NULL,
	[pm_id] [int] NOT NULL,
	[sys_date] [datetime] NOT NULL,
	[pro_txm] [varchar](20) NOT NULL,
	[pro_spec] [varchar](50) NULL,
	[pro_model] [varchar](50) NULL,
	[pro_inprice] [decimal](18, 4) NOT NULL,
	[pro_inprice_tax] [decimal](18, 4) NOT NULL,
	[pro_price] [decimal](18, 2) NOT NULL,
	[pro_marketprice] [decimal](18, 2) NOT NULL,
	[pro_outprice] [decimal](18, 2) NOT NULL,
	[pro_outprice_advanced] [decimal](18, 2) NOT NULL,
	[pro_settleprice] [decimal](18, 2) NOT NULL,
	[ecm_specid] [int] NOT NULL,
 CONSTRAINT [PK_PRODUCT] PRIMARY KEY NONCLUSTERED 
(
	[pro_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'市场参考价' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'pro_price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'直营工厂店销售价' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'pro_marketprice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'批发价（档口及某些散户）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'pro_outprice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'一级批发商' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'pro_outprice_advanced'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结算价，加盟工厂店' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'pro_settleprice'
GO
/****** Object:  StoredProcedure [dbo].[sp_TablesPageNew]    Script Date: 12/04/2017 15:05:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_TablesPageNew]
( 
    @tblName nvarchar(1000),            ----要显示的表或多个表的连接
    @fields nvarchar(1000)='*',        ----要显示的字段列表
    @sortfields    nvarchar(100)='',    ----如果多列排序,一定要带asc或者desc,则@singleSortType排序方法无效，反之,单列根据@singleSortType来处理
    @singleSortType    int = 1,                ----排序方法，0为升序，1为降序
    @pageSize int = 10,                ----每页显示的记录个数
    @pageIndex    int = 1,                ----要显示那一页的记录
    @strCondition    nvarchar(1000)='',    ----查询条件,不需where    
    @Counts    int =1 output           ----查询到的记录数
) 

AS
set  nocount  on
/*
	作者：cy,sl
	时间：2010－12－27
	功能：实现多表分页查询；
*/
declare @sqlTmp nvarchar(2000)
declare @sqlGetCount nvarchar(2000)
declare @frontOrder nvarchar(200)
declare @behindOrder nvarchar(200)
declare @start nvarchar(20) 
declare @end nvarchar(20)
declare @pageCount INT

if @strCondition=''
	set @strCondition=' where 1=1'
else
	set @strCondition=' where '+@strCondition
begin
    if charindex(',',@sortfields,0)>0--多列排序,则@singleSortType排序方法无效
        begin
            set @frontOrder = @sortfields--获取分页前半部分数据的排序规则
            set @behindOrder = replace(@frontOrder,'desc','desctmp')
            set @behindOrder = replace(@behindOrder,'asc','desc')
            set @behindOrder = replace(@behindOrder,'desctmp','asc')--获取分页后半部分数据的排序规则
        end
    else--单列
        begin
            set @sortfields=replace(replace(@sortfields,'desc',''),'asc','')--替换掉结尾的规则,用@singleSortType值来处理排序
            if @singleSortType=1--倒序
                begin
                    set @frontOrder = @sortfields + ' desc'
                    set @behindOrder = @sortfields + ' asc'
					set @sortfields=@sortfields+' desc'
                end
                
            else
                begin
                    set @frontOrder = @sortfields + ' asc'
                    set @behindOrder = @sortfields + ' desc'
					set @sortfields=@sortfields+' asc'
                end
    end

    --获取记录数
    
      set @sqlGetCount = 'select @Counts=count(*) from ' + @tblName + @strCondition


    ----取得查询结果总数量-----
    exec sp_executesql @sqlGetCount,N'@Counts int out ',@Counts out
    declare @tmpCounts int
    if @Counts = 0
        set @tmpCounts = 1
    else
        set @tmpCounts = @Counts

    --取得分页总数
    set @pageCount=(@tmpCounts+@pageSize-1)/@pageSize

    /**当前页大于总页数 取最后一页**/
    if @pageIndex>@pageCount
        set @pageIndex=@pageCount
    /*-----数据分页2分处理-------*/
    declare @pageIndexNew int --总数/页大小
    declare @lastcount int --总数%页大小 最后一页的数据量

    set @pageIndexNew = @tmpCounts/@pageSize
    set @lastcount = @tmpCounts%@pageSize
    if @lastcount > 0
        set @pageIndexNew = @pageIndexNew + 1
    else
        set @lastcount = @pagesize

    --取得数据的逻辑分析
		  if @pageIndexNew<2 or @pageIndex<=@pageIndexNew / 2 + @pageIndexNew % 2   --前半部分数据处理
			begin 
				--计算开始结束的行号
				set @start = @pageSize*(@pageIndex-1)+1
				set @end =     @start+@pageSize-1 
				set @sqlTmp='SELECT * FROM (select '+@fields+',ROW_NUMBER() OVER ( Order by '+@frontOrder+' ) AS RowNumber From '+@tblName+@strCondition+') T WHERE T.RowNumber BETWEEN '+@start+' AND '+@end+' order by '+@sortfields
			end
		else
			begin
			set @pageIndex = @pageIndexNew-@pageIndex+1 --后半部分数据处理
			if @lastcount=@pageSize --如果正好是整数页
				begin
					set @start = @pageSize*(@pageIndex-1)+1
					set @end =     @start+@pageSize-1
				end
			else
				begin
					set @start = @lastcount+@pageSize*(@pageIndex-2)+1
					set @end =     @start+@pageSize-1
				end
			set @sqlTmp='select top '+@end+' * FROM (select '+@fields+',ROW_NUMBER() OVER ( Order by '+@behindOrder+' ) AS RowNumber From '+@tblName+@strCondition+') T WHERE T.RowNumber BETWEEN '+@start+' AND '+@end+'  order by '+@sortfields
			end
        end
--print @sqlTmp
exec sp_executesql @sqlTmp
GO
/****** Object:  StoredProcedure [dbo].[sp_TablesPage]    Script Date: 12/04/2017 15:05:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_TablesPage]
( 
    @tblName nvarchar(1000),            ----要显示的表或多个表的连接
    @fields nvarchar(1000)='*',        ----要显示的字段列表
    @sortfields    nvarchar(100)='',    ----如果多列排序,一定要带asc或者desc,则@singleSortType排序方法无效，反之,单列根据@singleSortType来处理
    @singleSortType    int = 1,                ----排序方法，0为升序，1为降序
    @pageSize int = 10,                ----每页显示的记录个数
    @pageIndex    int = 1,                ----要显示那一页的记录
    @strCondition    nvarchar(1000)='',    ----查询条件,不需where    
    @Counts    int =1 output           ----查询到的记录数
) 

AS
/*
	作者：cy,sl
	时间：2010－12－27
	功能：实现多表分页查询；
*/
declare @sqlTmp nvarchar(2000)
declare @sqlGetCount nvarchar(2000)
declare @frontOrder nvarchar(200)
declare @behindOrder nvarchar(200)
declare @start nvarchar(20) 
declare @end nvarchar(20)
declare @pageCount INT
if @strCondition=''
	set @strCondition=' where 1=1'
else
	set @strCondition=' where '+@strCondition
begin
    if charindex(',',@sortfields,0)>0--多列排序,则@singleSortType排序方法无效
        begin
            set @frontOrder = @sortfields--获取分页前半部分数据的排序规则
            set @behindOrder = replace(@frontOrder,'desc','desctmp')
            set @behindOrder = replace(@behindOrder,'asc','desc')
            set @behindOrder = replace(@behindOrder,'desctmp','asc')--获取分页后半部分数据的排序规则
        end
    else--单列
        begin
            set @sortfields=replace(replace(@sortfields,'desc',''),'asc','')--替换掉结尾的规则,用@singleSortType值来处理排序
            if @singleSortType=1--倒序
                begin
                    set @frontOrder = @sortfields + ' desc'
                    set @behindOrder = @sortfields + ' asc'
                end
                
            else
                begin
                    set @frontOrder = @sortfields + ' asc'
                    set @behindOrder = @sortfields + ' desc'
                end
    end

    --获取记录数
    
      set @sqlGetCount = 'select @Counts=count(*) from ' + @tblName + @strCondition


    ----取得查询结果总数量-----
    exec sp_executesql @sqlGetCount,N'@Counts int out ',@Counts out
    declare @tmpCounts int
    if @Counts = 0
        set @tmpCounts = 1
    else
        set @tmpCounts = @Counts

    --取得分页总数
    set @pageCount=(@tmpCounts+@pageSize-1)/@pageSize

    /**当前页大于总页数 取最后一页**/
    if @pageIndex>@pageCount
        set @pageIndex=@pageCount
    /*-----数据分页2分处理-------*/
    declare @pageIndexNew int --总数/页大小
    declare @lastcount int --总数%页大小 最后一页的数据量

    set @pageIndexNew = @tmpCounts/@pageSize
    set @lastcount = @tmpCounts%@pageSize
    if @lastcount > 0
        set @pageIndexNew = @pageIndexNew + 1
    else
        set @lastcount = @pagesize

    --取得数据的逻辑分析
		  if @pageIndexNew<2 or @pageIndex<=@pageIndexNew / 2 + @pageIndexNew % 2   --前半部分数据处理
			begin 
				--计算开始结束的行号
				set @start = @pageSize*(@pageIndex-1)+1
				set @end =     @start+@pageSize-1 
				set @sqlTmp='SELECT * FROM (select '+@fields+',ROW_NUMBER() OVER ( Order by '+@frontOrder+' ) AS RowNumber From '+@tblName+@strCondition+') T WHERE T.RowNumber BETWEEN '+@start+' AND '+@end
			end
		else
			begin
			set @pageIndex = @pageIndexNew-@pageIndex+1 --后半部分数据处理
			if @lastcount=@pageSize --如果正好是整数页
				begin
					set @start = @pageSize*(@pageIndex-1)+1
					set @end =     @start+@pageSize-1
				end
			else
				begin
					set @start = @lastcount+@pageSize*(@pageIndex-2)+1
					set @end =     @start+@pageSize-1
				end
			set @sqlTmp='select top '+@end+' * FROM (select '+@fields+',ROW_NUMBER() OVER ( Order by '+@behindOrder+' ) AS RowNumber From '+@tblName+@strCondition+') T WHERE T.RowNumber BETWEEN '+@start+' AND '+@end+' order by RowNumber desc '
			end
        end
exec sp_executesql @sqlTmp
GO
/****** Object:  StoredProcedure [dbo].[sp_pager]    Script Date: 12/04/2017 15:05:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_pager]
(
@tblName   varchar(255),       -- 表名
@strGetFields varchar(1000) = '*',  -- 需要返回的列 
@fldName varchar(255)='',      -- 排序的字段名
@PageSize   int = 40,          -- 页尺寸
@PageIndex  int = 1,           -- 页码
@doCount  bit = 0,   -- 返回记录总数, 非 0 值则返回
@OrderType bit = 0,  -- 设置排序类型, 非 0 值则降序
@strWhere  varchar(1500)=''  -- 查询条件 (注意: 不要加 where)
)
AS
declare @strSQL   varchar(5000)       -- 主语句
declare @strTmp   varchar(110)        -- 临时变量
declare @strOrder varchar(400)        -- 排序类型
if @doCount != 0
  begin
    if @strWhere !=''
    set @strSQL = 'select count(*) as Total from ' + @tblName + ' where '+@strWhere
    else
    set @strSQL = 'select count(*) as Total from ' + @tblName 
end  
--以上代码的意思是如果@doCount传递过来的不是0，就执行总数统计。以下的所有代码都是@doCount为0的情况
else
begin
if @OrderType != 0
begin
    set @strTmp = '<(select min'
set @strOrder = ' order by ' + @fldName +' desc'
--如果@OrderType不是0，就执行降序，这句很重要！
End
else
begin
    set @strTmp = '>(select max'
    set @strOrder = ' order by ' + @fldName +' asc'
end
if @PageIndex = 1
begin
    if @strWhere != ''   
    set @strSQL = 'select top ' + str(@PageSize) +' '+@strGetFields+ '  from ' + @tblName + ' where ' + @strWhere + ' ' + @strOrder
     else
     set @strSQL = 'select top ' + str(@PageSize) +' '+@strGetFields+ '  from '+ @tblName + ' '+ @strOrder
--如果是第一页就执行以上代码，这样会加快执行速度
end
else
begin
--以下代码赋予了@strSQL以真正执行的SQL代码
set @strSQL = 'select top ' + str(@PageSize) +' '+@strGetFields+ '  from '
    + @tblName + ' where ' + @fldName + '' + @strTmp + '('+ @fldName + ') from (select top ' + str((@PageIndex-1)*@PageSize) + ' '+ @fldName + ' from ' + @tblName + '' + @strOrder + ') as tblTmp)'+ @strOrder
if @strWhere != ''
    set @strSQL = 'select top ' + str(@PageSize) +' '+@strGetFields+ '  from '
        + @tblName + ' where ' + @fldName + '' + @strTmp + '('
        + @fldName + ') from (select top ' + str((@PageIndex-1)*@PageSize) + ' '
        + @fldName + ' from ' + @tblName + ' where ' + @strWhere + ' '
        + @strOrder + ') as tblTmp) and ' + @strWhere + ' ' + @strOrder
end 
end   
exec (@strSQL)


--exec sp_page 'employees', 'employeeid, lastname, firstname', employeeid, 3, 1

--@tblName   varchar(255),       -- 表名
--@strGetFields varchar(1000) = '*',  -- 需要返回的列 
--@fldName varchar(255)='',      -- 排序的字段名
--@PageSize   int = 40,          -- 页尺寸
--@PageIndex  int = 1,           -- 页码
--@doCount  bit = 0,   -- 返回记录总数, 非 0 值则返回
--@OrderType bit = 0,  -- 设置排序类型, 非 0 值则降序
--@strWhere  varchar(1500)=''  -- 查询条件 (注意: 不要加 where)
GO
/****** Object:  Table [dbo].[UserMoneyAction]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserMoneyAction](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [varchar](50) NULL,
	[MoneyAmount] [real] NOT NULL,
	[DoFlag] [tinyint] NOT NULL,
	[AddTime] [datetime] NOT NULL,
	[DingDan] [varchar](50) NULL,
 CONSTRAINT [PK_UserMoneyAction] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户总金额变动' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserMoneyAction'
GO
/****** Object:  Table [dbo].[UpdateTime]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UpdateTime](
	[ID] [int] NOT NULL,
	[ToServerTime] [datetime] NULL,
	[FromServerTime] [datetime] NULL,
 CONSTRAINT [PK_UpdateTime] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'导到本地时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UpdateTime', @level2type=N'COLUMN',@level2name=N'ToServerTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新远程服务器时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UpdateTime', @level2type=N'COLUMN',@level2name=N'FromServerTime'
GO
/****** Object:  Table [dbo].[Tb_Working_material]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_Working_material](
	[wp_id] [int] IDENTITY(1,1) NOT NULL,
	[wm_id] [int] NOT NULL,
	[work_id] [int] NULL,
	[tpt_id] [int] NULL,
	[pro_txm] [varchar](50) NULL,
	[pro_id] [int] NULL,
	[pro_nums] [decimal](18, 2) NULL,
	[pro_real_nums] [decimal](18, 2) NOT NULL,
	[pro_inprice] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Tb_Working_material] PRIMARY KEY CLUSTERED 
(
	[wp_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tb_Working_main]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_Working_main](
	[wm_id] [int] IDENTITY(1,1) NOT NULL,
	[work_id] [int] NULL,
	[tpl_id] [int] NULL,
	[pro_code_new] [varchar](50) NOT NULL,
	[quantity] [int] NOT NULL,
	[do_cost] [decimal](18, 0) NOT NULL,
	[other_cost] [decimal](18, 0) NOT NULL,
	[material_cost] [decimal](18, 2) NOT NULL,
	[all_cost_every]  AS (([do_cost]+[other_cost])+[material_cost]),
	[operator_id] [int] NOT NULL,
 CONSTRAINT [PK_Tb_Working_main] PRIMARY KEY CLUSTERED 
(
	[wm_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tb_working_cart_del]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tb_working_cart_del](
	[cart_id] [int] IDENTITY(1,1) NOT NULL,
	[tpl_id] [int] NOT NULL,
	[quantity] [real] NOT NULL,
	[operator_id] [int] NOT NULL,
	[add_time] [datetime] NOT NULL,
	[update_time] [datetime] NULL,
 CONSTRAINT [PK_Tb_working_cart] PRIMARY KEY CLUSTERED 
(
	[cart_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tb_Working]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_Working](
	[work_id] [int] IDENTITY(1,1) NOT NULL,
	[work_sn] [varchar](50) NOT NULL,
	[factory_id] [int] NOT NULL,
	[warehouse_id] [int] NOT NULL,
	[start_date] [datetime] NULL,
	[end_date] [datetime] NULL,
	[real_date] [datetime] NULL,
	[add_time] [datetime] NOT NULL,
	[work_status] [tinyint] NULL,
	[our_manager] [nvarchar](50) NOT NULL,
	[factory_manager] [nvarchar](50) NULL,
	[work_remark] [nvarchar](50) NULL,
	[operator_id] [int] NOT NULL,
 CONSTRAINT [PK_Tb_Working] PRIMARY KEY CLUSTERED 
(
	[work_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tb_Working', @level2type=N'COLUMN',@level2name=N'work_sn'
GO
/****** Object:  Table [dbo].[Tb_User]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_User](
	[User_id] [int] IDENTITY(1,1) NOT NULL,
	[User_name] [varchar](50) NOT NULL,
	[True_name] [varchar](50) NOT NULL,
	[Add_time] [datetime] NOT NULL,
	[User_Pwd] [char](32) NOT NULL,
	[User_level] [int] NOT NULL,
	[User_Mobile] [varchar](50) NOT NULL,
	[last_login] [datetime] NULL,
	[cashier_id_from] [int] NOT NULL,
	[store_id_from] [int] NOT NULL,
	[Account_money] [decimal](18, 2) NOT NULL,
	[Account_score] [decimal](18, 2) NOT NULL,
	[is_hide] [tinyint] NOT NULL,
 CONSTRAINT [PK_Tb_User] PRIMARY KEY CLUSTERED 
(
	[User_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tb_template_material]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_template_material](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tpl_id] [int] NOT NULL,
	[pro_txm_from] [varchar](50) NOT NULL,
	[pro_id_from] [int] NOT NULL,
	[pro_nums] [decimal](18, 2) NOT NULL,
	[add_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Tb_template_material] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tb_template]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_template](
	[tpl_id] [int] IDENTITY(1,1) NOT NULL,
	[pro_name] [nvarchar](50) NOT NULL,
	[pro_code] [varchar](50) NOT NULL,
	[factory_id] [int] NOT NULL,
	[do_cost] [decimal](18, 2) NOT NULL,
	[other_cost] [decimal](18, 2) NOT NULL,
	[add_time] [datetime] NOT NULL,
	[update_time] [datetime] NULL,
	[operator] [int] NOT NULL,
	[tpl_status] [tinyint] NOT NULL,
	[remark] [nvarchar](255) NULL,
 CONSTRAINT [PK_Tb_template] PRIMARY KEY CLUSTERED 
(
	[tpl_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'加工费' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tb_template', @level2type=N'COLUMN',@level2name=N'do_cost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'其它费用' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tb_template', @level2type=N'COLUMN',@level2name=N'other_cost'
GO
/****** Object:  Table [dbo].[Tb_storage_product]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_storage_product](
	[p_id] [int] IDENTITY(1,1) NOT NULL,
	[pro_id] [int] NOT NULL,
	[sm_id] [int] NOT NULL,
	[sku_id] [int] NOT NULL,
	[p_name] [varchar](50) NOT NULL,
	[p_serial] [varchar](20) NOT NULL,
	[p_txm] [varchar](20) NOT NULL,
	[p_spec] [varchar](50) NULL,
	[p_model] [varchar](50) NULL,
	[p_price] [decimal](18, 2) NOT NULL,
	[p_quantity] [decimal](18, 2) NOT NULL,
	[p_baseprice] [decimal](18, 2) NOT NULL,
	[p_brand] [nvarchar](50) NULL,
	[p_unit] [nvarchar](20) NULL,
	[p_oldtxm] [varchar](50) NOT NULL,
	[p_box] [varchar](20) NOT NULL,
 CONSTRAINT [PK_ecm_storage_product] PRIMARY KEY CLUSTERED 
(
	[p_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'规格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tb_storage_product', @level2type=N'COLUMN',@level2name=N'p_spec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'型号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tb_storage_product', @level2type=N'COLUMN',@level2name=N'p_model'
GO
/****** Object:  Table [dbo].[Tb_storage_main]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_storage_main](
	[sm_id] [int] IDENTITY(1,1) NOT NULL,
	[sm_type] [tinyint] NOT NULL,
	[store_id] [int] NOT NULL,
	[sm_sn] [varchar](20) NOT NULL,
	[sm_box] [varchar](20) NOT NULL,
	[warehouse_id] [int] NOT NULL,
	[warehouse_id_to] [int] NOT NULL,
	[warehouse_id_from] [int] NOT NULL,
	[sm_supplierid] [int] NOT NULL,
	[sm_supplier] [varchar](100) NOT NULL,
	[sm_date] [datetime] NOT NULL,
	[sm_operator] [nvarchar](50) NOT NULL,
	[consumer_id] [int] NOT NULL,
	[consumer_name] [nvarchar](50) NOT NULL,
	[add_time] [datetime] NOT NULL,
	[sm_remark] [varchar](500) NOT NULL,
	[sm_status] [tinyint] NOT NULL,
	[sm_adminid] [int] NOT NULL,
	[sm_iscloth] [tinyint] NOT NULL,
	[sm_direction] [nvarchar](10) NOT NULL,
	[is_direct] [int] NOT NULL,
	[relate_sn] [varchar](20) NOT NULL,
	[sm_verify_adminid] [int] NOT NULL,
 CONSTRAINT [PK_ecm_storage_main] PRIMARY KEY CLUSTERED 
(
	[sm_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'目标仓' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tb_storage_main', @level2type=N'COLUMN',@level2name=N'warehouse_id_to'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'直接转出库' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tb_storage_main', @level2type=N'COLUMN',@level2name=N'is_direct'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'关联单' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tb_storage_main', @level2type=N'COLUMN',@level2name=N'relate_sn'
GO
/****** Object:  Table [dbo].[Tb_plan_product]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_plan_product](
	[p_id] [int] IDENTITY(1,1) NOT NULL,
	[pro_id] [int] NOT NULL,
	[sm_id] [int] NOT NULL,
	[sku_id] [int] NOT NULL,
	[p_name] [varchar](50) NOT NULL,
	[p_serial] [varchar](50) NOT NULL,
	[p_txm] [varchar](20) NOT NULL,
	[p_spec] [varchar](50) NULL,
	[p_model] [varchar](50) NULL,
	[p_price] [decimal](18, 2) NOT NULL,
	[p_quantity] [decimal](18, 2) NOT NULL,
	[p_baseprice] [decimal](18, 4) NOT NULL,
	[p_baseprice_tax] [decimal](18, 4) NOT NULL,
	[p_brand] [nvarchar](50) NULL,
	[p_unit] [nvarchar](20) NULL,
	[p_oldtxm] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tb_storage_product] PRIMARY KEY CLUSTERED 
(
	[p_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'规格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tb_plan_product', @level2type=N'COLUMN',@level2name=N'p_spec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'型号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tb_plan_product', @level2type=N'COLUMN',@level2name=N'p_model'
GO
/****** Object:  Table [dbo].[Tb_plan_main]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_plan_main](
	[sm_id] [int] IDENTITY(1,1) NOT NULL,
	[sm_type] [tinyint] NOT NULL,
	[store_id] [int] NOT NULL,
	[sm_sn] [varchar](20) NOT NULL,
	[warehouse_id] [int] NOT NULL,
	[warehouse_id_to] [int] NOT NULL,
	[sm_supplierid] [int] NOT NULL,
	[sm_supplier] [varchar](100) NOT NULL,
	[sm_date] [datetime] NOT NULL,
	[sm_operator] [varchar](20) NOT NULL,
	[add_time] [datetime] NOT NULL,
	[sm_remark] [varchar](500) NOT NULL,
	[sm_status] [tinyint] NOT NULL,
	[sm_adminid] [int] NOT NULL,
	[sm_iscloth] [tinyint] NOT NULL,
	[sm_tax] [decimal](18, 3) NOT NULL,
	[relate_warehouse_id] [int] NOT NULL,
 CONSTRAINT [PK_tb_storage_main] PRIMARY KEY CLUSTERED 
(
	[sm_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'目标仓' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tb_plan_main', @level2type=N'COLUMN',@level2name=N'warehouse_id_to'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'调货时相关仓 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tb_plan_main', @level2type=N'COLUMN',@level2name=N'relate_warehouse_id'
GO
/****** Object:  Table [dbo].[Tb_need_product]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_need_product](
	[p_id] [int] IDENTITY(1,1) NOT NULL,
	[pro_id] [int] NOT NULL,
	[sm_id] [int] NOT NULL,
	[sku_id] [int] NOT NULL,
	[p_name] [varchar](50) NOT NULL,
	[p_serial] [varchar](20) NOT NULL,
	[p_txm] [varchar](20) NOT NULL,
	[p_spec] [varchar](50) NULL,
	[p_model] [varchar](50) NULL,
	[p_price] [decimal](18, 2) NOT NULL,
	[p_quantity] [decimal](18, 2) NOT NULL,
	[p_baseprice] [decimal](18, 2) NOT NULL,
	[p_brand] [nvarchar](50) NULL,
	[p_unit] [nvarchar](20) NULL,
	[p_oldtxm] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Tb_need_product] PRIMARY KEY CLUSTERED 
(
	[p_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'规格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tb_need_product', @level2type=N'COLUMN',@level2name=N'p_spec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'型号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tb_need_product', @level2type=N'COLUMN',@level2name=N'p_model'
GO
/****** Object:  Table [dbo].[Tb_need_main]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_need_main](
	[sm_id] [int] IDENTITY(1,1) NOT NULL,
	[sm_type] [tinyint] NOT NULL,
	[sm_sn] [varchar](20) NOT NULL,
	[warehouse_id] [int] NOT NULL,
	[warehouse_id_from] [int] NOT NULL,
	[sm_supplierid] [int] NOT NULL,
	[sm_supplier] [varchar](100) NOT NULL,
	[sm_date] [datetime] NOT NULL,
	[sm_operator] [varchar](20) NOT NULL,
	[add_time] [datetime] NOT NULL,
	[sm_remark] [varchar](500) NOT NULL,
	[sm_status] [tinyint] NOT NULL,
	[sm_adminid] [int] NOT NULL,
	[sm_verify_adminid] [int] NOT NULL,
 CONSTRAINT [PK_Tb_need_main] PRIMARY KEY CLUSTERED 
(
	[sm_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tb_guide_staff]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tb_guide_staff](
	[guide_id] [int] IDENTITY(1,1) NOT NULL,
	[store_id] [int] NOT NULL,
	[guide_name] [nvarchar](50) NOT NULL,
	[add_time] [datetime] NOT NULL,
	[is_hide] [tinyint] NOT NULL,
	[guide_remark] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Tb_guide_staff] PRIMARY KEY CLUSTERED 
(
	[guide_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tb_GoodsReturnReson]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tb_GoodsReturnReson](
	[typeId] [int] IDENTITY(1,1) NOT NULL,
	[typeName] [nvarchar](50) NULL,
	[typeSort] [int] NOT NULL,
	[isHidden] [tinyint] NOT NULL,
	[addTime] [datetime] NULL,
 CONSTRAINT [PK_Tb_GoodsReturnReson] PRIMARY KEY CLUSTERED 
(
	[typeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'返货原因表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tb_GoodsReturnReson'
GO
/****** Object:  Table [dbo].[TB_GoodsReturnOrder]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_GoodsReturnOrder](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [varchar](50) NOT NULL,
	[AddTime] [datetime] NOT NULL,
	[OrderStatus] [int] NOT NULL,
	[province] [nvarchar](50) NULL,
	[city] [nvarchar](50) NULL,
	[xian] [nvarchar](50) NULL,
	[PostAddress] [nvarchar](100) NULL,
	[UserTel] [varchar](50) NULL,
	[AgentId] [varchar](50) NULL,
	[ReveivedName] [varchar](50) NULL,
	[DeliverTime] [datetime] NULL,
	[Remark] [varchar](max) NULL,
	[DeliverOperator] [varchar](50) NULL,
	[ExpressCompany] [nvarchar](50) NULL,
	[ExpressNo] [varchar](50) NULL,
	[liushuihao] [varchar](50) NULL,
 CONSTRAINT [PK_TB_GoodsReturnOrder] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'返货订单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GoodsReturnOrder', @level2type=N'COLUMN',@level2name=N'OrderId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生成时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GoodsReturnOrder', @level2type=N'COLUMN',@level2name=N'AddTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GoodsReturnOrder', @level2type=N'COLUMN',@level2name=N'OrderStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'省' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GoodsReturnOrder', @level2type=N'COLUMN',@level2name=N'province'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'市' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GoodsReturnOrder', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'县' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GoodsReturnOrder', @level2type=N'COLUMN',@level2name=N'xian'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收货地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GoodsReturnOrder', @level2type=N'COLUMN',@level2name=N'PostAddress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'相关代理' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GoodsReturnOrder', @level2type=N'COLUMN',@level2name=N'AgentId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收货人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GoodsReturnOrder', @level2type=N'COLUMN',@level2name=N'ReveivedName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发货时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GoodsReturnOrder', @level2type=N'COLUMN',@level2name=N'DeliverTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GoodsReturnOrder', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发货人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GoodsReturnOrder', @level2type=N'COLUMN',@level2name=N'DeliverOperator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物流公司' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GoodsReturnOrder', @level2type=N'COLUMN',@level2name=N'ExpressCompany'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'快递单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GoodsReturnOrder', @level2type=N'COLUMN',@level2name=N'ExpressNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'返货商品生成订单' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GoodsReturnOrder'
GO
/****** Object:  Table [dbo].[TB_GoodsReturn]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_GoodsReturn](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [varchar](255) NOT NULL,
	[ProductCount] [real] NOT NULL,
	[DingDan] [varchar](50) NULL,
	[AgentId] [varchar](50) NULL,
	[ReturnTime] [varchar](50) NULL,
	[ProductTxm] [varchar](50) NULL,
	[ReturnReson] [nvarchar](max) NULL,
	[ReceivedOpter] [varchar](50) NULL,
	[AddTime] [datetime] NOT NULL,
	[Status] [int] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[Operator] [varchar](50) NULL,
	[GoodsFrom] [tinyint] NOT NULL,
	[OrderType] [tinyint] NOT NULL,
	[ReturnOrderId] [varchar](50) NULL,
	[UserName] [nvarchar](50) NULL,
	[UserTel] [varchar](50) NULL,
	[UserProvince] [varchar](50) NULL,
	[UserCity] [varchar](50) NULL,
	[UserTown] [varchar](50) NULL,
	[UserAddress] [varchar](100) NULL,
	[PostFee] [varchar](50) NULL,
	[ReturnRemark] [nvarchar](max) NULL,
	[ChangeFlag] [int] NOT NULL,
 CONSTRAINT [PK_TB_GoodsReturn] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GoodsReturn', @level2type=N'COLUMN',@level2name=N'Operator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'返货来自,0表本仓,1为外仓调入' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GoodsReturn', @level2type=N'COLUMN',@level2name=N'GoodsFrom'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单类型，0为代理，1为分销' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GoodsReturn', @level2type=N'COLUMN',@level2name=N'OrderType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'返货订单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GoodsReturn', @level2type=N'COLUMN',@level2name=N'ReturnOrderId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'调换标识,0表普通未调换,-1表被调换,>0表调换对像的ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GoodsReturn', @level2type=N'COLUMN',@level2name=N'ChangeFlag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'返货表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GoodsReturn'
GO
/****** Object:  Table [dbo].[Tb_FinancialFlow]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tb_FinancialFlow](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[sm_id] [int] NOT NULL,
	[pay_money] [decimal](18, 2) NOT NULL,
	[pay_date] [datetime] NULL,
	[add_time] [datetime] NOT NULL,
	[admin_id] [int] NOT NULL,
	[pay_worker] [nvarchar](50) NOT NULL,
	[receive_worker] [nvarchar](50) NOT NULL,
	[remark] [nvarchar](800) NULL,
	[is_cancel] [tinyint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tb_Factory_del]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_Factory_del](
	[ft_id] [int] IDENTITY(1,1) NOT NULL,
	[FactoryName] [nvarchar](50) NOT NULL,
	[FactoryAddress] [nvarchar](50) NULL,
	[Telephone] [varchar](50) NULL,
	[AddTime] [datetime] NOT NULL,
	[IsLock] [tinyint] NOT NULL,
 CONSTRAINT [PK_Tb_Factory] PRIMARY KEY CLUSTERED 
(
	[ft_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tb_check_main]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_check_main](
	[main_id] [int] IDENTITY(1,1) NOT NULL,
	[check_sn] [varchar](20) NOT NULL,
	[warehouse_id] [int] NOT NULL,
	[add_time] [datetime] NOT NULL,
	[update_time] [datetime] NOT NULL,
	[manager] [varchar](20) NULL,
	[operator_id] [int] NOT NULL,
	[remark] [nvarchar](200) NULL,
 CONSTRAINT [PK_Tb_check_main] PRIMARY KEY CLUSTERED 
(
	[main_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tb_check_input]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_check_input](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[main_id] [int] NOT NULL,
	[pro_txm] [varchar](20) NOT NULL,
	[check_num] [int] NOT NULL,
	[area_code] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Tb_check_input] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tb_check_detail]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_check_detail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[main_id] [int] NOT NULL,
	[pro_id] [int] NOT NULL,
	[pro_txm] [varchar](20) NOT NULL,
	[kc_num] [int] NOT NULL,
	[check_num] [int] NOT NULL,
	[add_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Tb_check_detail] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tb_ChangeStockRecord]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_ChangeStockRecord](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[warehouse_id] [int] NOT NULL,
	[pro_id] [int] NOT NULL,
	[change_type] [int] NOT NULL,
	[quantity] [decimal](18, 2) NOT NULL,
	[old_num] [decimal](18, 2) NOT NULL,
	[new_num] [decimal](18, 2) NOT NULL,
	[do_why] [nvarchar](250) NULL,
	[do_ip] [varchar](50) NULL,
	[change_time] [datetime] NOT NULL,
	[order_sn] [varchar](50) NULL,
 CONSTRAINT [PK_Tb_ChangeStockRecord] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tb_cashier_cart]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_cashier_cart](
	[rec_id] [int] IDENTITY(1,1) NOT NULL,
	[cashier_id] [int] NOT NULL,
	[trace_id] [int] NOT NULL,
	[store_id] [int] NOT NULL,
	[txm] [varchar](50) NOT NULL,
	[goods_id] [int] NOT NULL,
	[goods_name] [nvarchar](100) NOT NULL,
	[spec_id] [int] NOT NULL,
	[specification] [nvarchar](50) NULL,
	[price] [decimal](10, 2) NOT NULL,
	[voucher_price] [decimal](10, 2) NULL,
	[quantity] [int] NOT NULL,
	[goods_image] [varchar](100) NULL,
	[is_return] [tinyint] NOT NULL,
	[order_goods_id] [int] NOT NULL,
 CONSTRAINT [PK_Tb_cashier_cart] PRIMARY KEY CLUSTERED 
(
	[rec_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tb_brand]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_brand](
	[brand_id] [int] IDENTITY(1,1) NOT NULL,
	[brand_name] [varchar](50) NOT NULL,
	[add_time] [datetime] NOT NULL,
	[brand_remark] [varchar](50) NULL,
	[is_hide] [tinyint] NOT NULL,
 CONSTRAINT [PK_Tb_brand] PRIMARY KEY CLUSTERED 
(
	[brand_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tb_Agent]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tb_Agent](
	[Agent_id] [int] IDENTITY(1,1) NOT NULL,
	[Agent_name] [nvarchar](50) NOT NULL,
	[Agent_remark] [nvarchar](250) NULL,
	[is_hide] [tinyint] NOT NULL,
	[add_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Tb_Agent] PRIMARY KEY CLUSTERED 
(
	[Agent_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[supplier]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[supplier](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[supplier_name] [varchar](100) NULL,
	[leijijiner] [money] NOT NULL,
	[weijiejiner] [money] NOT NULL,
	[wuliushijian] [int] NOT NULL,
	[serviceTel] [varchar](50) NULL,
	[store_logo] [varchar](100) NULL,
	[add_date] [datetime] NOT NULL,
	[supplier_address] [nvarchar](100) NULL,
	[IsLock] [tinyint] NOT NULL,
	[IsFactory] [tinyint] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'累计送货金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'supplier', @level2type=N'COLUMN',@level2name=N'leijijiner'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'未结算金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'supplier', @level2type=N'COLUMN',@level2name=N'weijiejiner'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物流周期(天)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'supplier', @level2type=N'COLUMN',@level2name=N'wuliushijian'
GO
/****** Object:  Table [dbo].[SinoRoleModule]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SinoRoleModule](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [int] NOT NULL,
	[ModuleID] [int] NOT NULL,
	[PowerStr] [char](6) NULL,
	[AddTime] [datetime] NOT NULL,
 CONSTRAINT [PK_SinoRoleModule] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SinoRoleModule', @level2type=N'COLUMN',@level2name=N'RoleID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模块ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SinoRoleModule', @level2type=N'COLUMN',@level2name=N'ModuleID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SinoRoleModule', @level2type=N'COLUMN',@level2name=N'PowerStr'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色与模块对应表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SinoRoleModule'
GO
/****** Object:  Table [dbo].[SinoRole]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SinoRole](
	[ID] [int] NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
	[RoleDes] [varchar](300) NULL,
	[CreateTime] [datetime] NOT NULL,
	[UpdateTime] [datetime] NOT NULL,
	[isAgent] [tinyint] NOT NULL,
 CONSTRAINT [PK_SinoRole] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分组角色名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SinoRole', @level2type=N'COLUMN',@level2name=N'RoleName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色分组说明' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SinoRole', @level2type=N'COLUMN',@level2name=N'RoleDes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SinoRole', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SinoRole', @level2type=N'COLUMN',@level2name=N'UpdateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户分组表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SinoRole'
GO
/****** Object:  Table [dbo].[SinoModule]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SinoModule](
	[ID] [int] NOT NULL,
	[ModuleName] [nvarchar](50) NOT NULL,
	[PageUrl] [nvarchar](200) NULL,
	[OrderNum] [int] NOT NULL,
	[ModuleDesc] [nvarchar](500) NULL,
	[IsShow] [tinyint] NOT NULL,
	[PID] [int] NOT NULL,
 CONSTRAINT [PK_SinoModule] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模块名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SinoModule', @level2type=N'COLUMN',@level2name=N'ModuleName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模块页面地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SinoModule', @level2type=N'COLUMN',@level2name=N'PageUrl'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SinoModule', @level2type=N'COLUMN',@level2name=N'OrderNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模块描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SinoModule', @level2type=N'COLUMN',@level2name=N'ModuleDesc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否作为菜单显示' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SinoModule', @level2type=N'COLUMN',@level2name=N'IsShow'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父级ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SinoModule', @level2type=N'COLUMN',@level2name=N'PID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'控制模块页面表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SinoModule'
GO
/****** Object:  Table [dbo].[wuliu_gongshi]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[wuliu_gongshi](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[wuliu_name] [varchar](50) NULL,
	[wuliu_address] [varchar](100) NULL,
	[wuliu_fanwei] [varchar](2000) NULL,
	[wuliu_tel] [varchar](1000) NULL,
	[add_date] [datetime] NULL,
	[add_user] [varchar](50) NULL,
	[wuliu_Url] [varchar](100) NULL,
	[is_Display] [int] NULL,
	[ServiceRate] [real] NULL,
	[IsExpress] [bit] NULL,
	[shfs] [int] NULL,
	[wuliu_sort] [int] NULL,
	[updateTime] [datetime] NULL,
	[isLocal] [tinyint] NULL,
 CONSTRAINT [PK_wuliu_gongshi] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'wuliu_gongshi', @level2type=N'COLUMN',@level2name=N'add_user'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代收现金的服务费率' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'wuliu_gongshi', @level2type=N'COLUMN',@level2name=N'ServiceRate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0:物流1:快递' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'wuliu_gongshi', @level2type=N'COLUMN',@level2name=N'IsExpress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'送货方式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'wuliu_gongshi', @level2type=N'COLUMN',@level2name=N'shfs'
GO
/****** Object:  Table [dbo].[WareHouse_List]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WareHouse_List](
	[warehouse_id] [int] IDENTITY(1,1) NOT NULL,
	[warehouse_name] [varchar](50) NOT NULL,
	[warehouse_address] [varchar](200) NULL,
	[warehouse_tel] [varchar](50) NULL,
	[add_date] [datetime] NOT NULL,
	[IsLock] [tinyint] NOT NULL,
	[StoreId] [int] NOT NULL,
	[is_caigou] [tinyint] NOT NULL,
	[is_manage] [tinyint] NOT NULL,
	[agent_id] [int] NOT NULL,
 CONSTRAINT [PK_WareHouse_List] PRIMARY KEY CLUSTERED 
(
	[warehouse_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'仓库的序号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WareHouse_List', @level2type=N'COLUMN',@level2name=N'warehouse_id'
GO
/****** Object:  Table [dbo].[wareHouse_Admin]    Script Date: 12/04/2017 15:04:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[wareHouse_Admin](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[warehouse_id] [int] NOT NULL,
	[LoginName] [nvarchar](50) NOT NULL,
	[fullname] [nvarchar](50) NULL,
	[add_date] [datetime] NOT NULL,
	[LoginPwd] [char](16) NOT NULL,
	[IsLock] [tinyint] NOT NULL,
	[RoleID] [int] NOT NULL,
 CONSTRAINT [PK_wareHouse_Admin] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_wareHouse_Admin] UNIQUE NONCLUSTERED 
(
	[LoginName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'仓库编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'wareHouse_Admin', @level2type=N'COLUMN',@level2name=N'warehouse_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'员工号也是登录账号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'wareHouse_Admin', @level2type=N'COLUMN',@level2name=N'LoginName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'真实姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'wareHouse_Admin', @level2type=N'COLUMN',@level2name=N'fullname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'加入时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'wareHouse_Admin', @level2type=N'COLUMN',@level2name=N'add_date'
GO
/****** Object:  View [dbo].[View_Product]    Script Date: 12/04/2017 15:05:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Product]
AS
SELECT     dbo.ProductStock.warehouse_id, dbo.ProductStock.in_nums, dbo.ProductStock.out_nums, dbo.Product.pro_txm, dbo.Product.pro_spec, dbo.Product.pro_model, 
                      dbo.ProductStock.kc_nums, dbo.Product.pro_id, dbo.ProductMain.pm_id, dbo.ProductMain.sys_date, dbo.ProductMain.pro_code, dbo.ProductMain.pro_name, 
                      dbo.ProductMain.pro_supplierid, dbo.ProductMain.pro_brand, dbo.ProductMain.pro_unit, dbo.ProductStock.stock_id, dbo.Product.pro_inprice, 
                      dbo.Product.pro_outprice, dbo.ProductStock.kc_flag, dbo.ProductMain.spec_name_1, dbo.ProductMain.spec_name_2, dbo.Product.pro_inprice_tax, 
                      dbo.ProductStock.shelf_no, dbo.ProductMain.type_id, dbo.ProductStock.do_nums, dbo.ProductStock.stock_price, dbo.ProductMain.pro_image, dbo.Product.pro_price, 
                      dbo.Product.pro_marketprice, dbo.Product.pro_settleprice, dbo.Product.pro_outprice_advanced
FROM         dbo.ProductStock INNER JOIN
                      dbo.Product ON dbo.ProductStock.pro_id = dbo.Product.pro_id INNER JOIN
                      dbo.ProductMain ON dbo.Product.pm_id = dbo.ProductMain.pm_id
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = -42
      End
      Begin Tables = 
         Begin Table = "ProductStock (dbo)"
            Begin Extent = 
               Top = 6
               Left = 80
               Bottom = 125
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Product (dbo)"
            Begin Extent = 
               Top = 6
               Left = 274
               Bottom = 125
               Right = 477
            End
            DisplayFlags = 280
            TopColumn = 9
         End
         Begin Table = "ProductMain (dbo)"
            Begin Extent = 
               Top = 126
               Left = 80
               Bottom = 245
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Product'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Product'
GO
/****** Object:  View [dbo].[Prolist]    Script Date: 12/04/2017 15:05:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Prolist]
AS
SELECT     dbo.ProductMain.pm_id, dbo.ProductMain.sys_date, dbo.ProductMain.pro_code, dbo.ProductMain.pro_name, dbo.Product.pro_spec, dbo.Product.pro_model, 
                      dbo.Product.pro_txm, dbo.Product.pro_inprice, dbo.Product.pro_inprice_tax, dbo.Product.pro_outprice, dbo.Product.pro_id, dbo.ProductMain.pro_supplierid, 
                      dbo.ProductMain.type_id, dbo.ProductMain.pro_brand, dbo.ProductMain.pro_unit, dbo.Product.pro_marketprice, dbo.ProductMain.pro_image, dbo.Product.pro_price, 
                      dbo.Product.pro_settleprice, dbo.Product.pro_outprice_advanced
FROM         dbo.ProductMain INNER JOIN
                      dbo.Product ON dbo.ProductMain.pm_id = dbo.Product.pm_id
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -96
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ProductMain (dbo)"
            Begin Extent = 
               Top = 102
               Left = 38
               Bottom = 221
               Right = 194
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Product (dbo)"
            Begin Extent = 
               Top = 102
               Left = 232
               Bottom = 221
               Right = 435
            End
            DisplayFlags = 280
            TopColumn = 10
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3465
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Prolist'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Prolist'
GO
/****** Object:  StoredProcedure [dbo].[Stock_Lessen]    Script Date: 12/04/2017 15:05:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Stock_Lessen]
/*

主要功能：仓库打单减未发
创建日期：2011-4-21
*/
(
@userid varchar(50),   --代理号
@dingdan varchar(50),  --订单号
@OrderIdentity int,	  --订单类型
@shopxp_shfs int		--发货方式
)
as

--引荐产品数量统计
declare @erqi_ck_temp table(id int identity(1,1),shopxp_yangshiid int,productcount real)


declare @warehouse_id int 
declare @msg nvarchar(1000)
--获取收货方式对应的仓库编号 
select @Warehouse_id=Warehouse_id from config_PostStyle  where songid=@shopxp_shfs

--插入产品的总销量表
--代理订单表
if @OrderIdentity=1
begin
	insert into @erqi_ck_temp (shopxp_yangshiid,productcount) 
	select shopxp_yangshiid,sum(productcount) from 
	(
	select shopxp_yangshiid,productcount=sum(productcount) from Order_Agent_ProDetail where userid=''+@userid+'' and dingdan=''+@dingdan+'' group by shopxp_yangshiid
	union select shopxp_yangshiid,productcount=sum(productcount) from Order_present_Agent where userid=''+@userid+'' and dingdan=''+@dingdan+'' group by shopxp_yangshiid	
	) as fxdd group by shopxp_yangshiid

	--更新用户的公司进货发票总额
	declare @dingdan_zonger real

	select @dingdan_zonger=isnull(sum(zonger),0) from Agent_Order_info where zhuangtai>=3 and zhuangtai<6 and dingdan=@dingdan and dingdan_type=2
	insert into UserMoneyAction(UserId,MoneyAmount,DingDan) values(@userid,@dingdan_zonger,@dingdan)
	--update e set e.jinhuo_zonger=e.jinhuo_zonger+@dingdan_zonger,e.gongshijinhuo_zonger=e.gongshijinhuo_zonger+@dingdan_zonger from e_user as e where e.userid=@userid
end


--分销中心订单表
if @OrderIdentity=0
begin
	insert into @erqi_ck_temp (shopxp_yangshiid,productcount) 
	select shopxp_yangshiid,sum(productcount) from 
	(
	select shopxp_yangshiid,productcount=sum(productcount) from Order_Distribution_ProDetail where userid=''+@userid+'' and dingdan=''+@dingdan+'' group by shopxp_yangshiid
	union select shopxp_yangshiid,productcount=sum(productcount) from Order_present_distribution where userid=''+@userid+'' and dingdan=''+@dingdan+'' group by shopxp_yangshiid	
	) as fxdd group by shopxp_yangshiid
end


if @OrderIdentity=3--展厅订单
begin
	insert into @erqi_ck_temp (shopxp_yangshiid,productcount) 
	select shopxp_yangshiid,sum(productcount) as productcount from 
	(
	select shopxp_yangshiid,productcount=sum(productcount) from Order_inside where dingdan=@dingdan group by shopxp_yangshiid	
	union select shopxp_yangshiid,productcount=sum(productcount) from  Order_present_inside where dingdan=@dingdan group by shopxp_yangshiid	
	) as order_insides group by shopxp_yangshiid
end


if @OrderIdentity=2--匿名订单表
begin
	insert into @erqi_ck_temp (shopxp_yangshiid,productcount) 
	select style_id,productcount=sum(pro_num) from Order_Extra_ProDetail where extra_userId=''+@userid+'' and dingdan=''+@dingdan+'' group by style_id
end

begin tran
   --减未发及添加日志记录开始####################################################
  
	declare @styleID int	--样式ID
	declare @num     real   ---商品数量
	declare @type  int		--处理类型
	declare @id int 

	
	--读取虚拟表@erqi_ck_temp中的缺货信息,每次读取一条
	select top 1 @id=id,@styleID=shopxp_yangshiid,@num=productcount from @erqi_ck_temp
	--判断虚拟表@t1中是否有值
	while @@rowcount>0 
	begin
	  
		--减未发库存日志
		exec sp_SingleChangeStockLog  @warehouse_id,@styleID,@num,@dingdan,5
		
		--减未发
		exec sp_SingleChangeStock_Dingdan  @warehouse_id,@styleID,@num,5,@dingdan
		
		--删除此条信息
		delete from @erqi_ck_temp where id=@id
		--循环读取@t1表，进入下一轮循环，直到@erqi_ck_temp表中已经没有值
		select top 1 @id=id,@styleID=shopxp_yangshiid,@num=productcount from @erqi_ck_temp
	end 
	--减未发及添加日志记录结束####################################################
commit tran
GO
/****** Object:  StoredProcedure [dbo].[Sp_getInPrice]    Script Date: 12/04/2017 15:05:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		xugj
-- Create date: <Create Date,,>
-- Description:	get jiaquanpingjunjai
-- =============================================
CREATE PROCEDURE [dbo].[Sp_getInPrice] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	update a set a.pro_inprice=b.baseprice,a.pro_inprice_tax=b.baseprice_tax from product a,
	(select p_txm,baseprice=SUM(p_baseprice*p_quantity)/SUM(p_quantity),baseprice_tax=SUM(p_baseprice_tax*p_quantity)/SUM(p_quantity) from Tb_plan_product where p_quantity>0 group by p_txm) as b 
	where a.pro_txm=b.p_txm
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_getDoNums]    Script Date: 12/04/2017 15:05:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		xuxgj
-- Create date: 2016-06-01
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Sp_getDoNums]
AS
BEGIN
	SET NOCOUNT ON;
	
	update  ProductStock set do_nums=0 where do_nums<>0
	update a set a.do_nums=w.quantity from ProductStock a,(select p.pro_id,m.warehouse_id,quantity=sum(p.p_quantity) from Tb_storage_product p left join Tb_storage_main m on p.sm_id=m.sm_id where m.sm_direction='出库' and m.sm_status in (0,3)
	group by m.warehouse_id,p.pro_id) as w where a.warehouse_id=w.warehouse_id and a.pro_id=w.pro_id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_AboutHuojiahao]    Script Date: 12/04/2017 15:05:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		sxf
-- Create date: 2011-12-21
-- Description:	批量更新代理或分销订单中货架号，商品区位编号,商品区位名等信息
-- =============================================
CREATE procedure [dbo].[sp_AboutHuojiahao]
(
@IsAgent tinyint   --1：代理订单  2：分销订单 3 ：代发订单
)
as
begin

	begin
		--更新直营代发货订单货架号相关为空的
		--update odp set huojiahao=wd.sanjian_huojiahao,area_number=wd.LocalNo,Storage_name=ss.Storage_name,StorageSortId=ss.id  from Direct_OrderDetail  odp INNER JOIN  WareHouse_Detail wd ON odp.style_id= wd.shopxp_yangshiid INNER JOIN Storage_Sort ss ON  wd.LocalNo = ss.Area_number  WHERE wd.warehouse_id=1 and (odp.huojiahao is null or odp.area_number=0 or odp.Storage_name is null or odp.StorageSortId=0)
		update odp set huojiahao=ps.shelf_no  from Direct_OrderDetail  odp inner join Product p on odp.txm=p.pro_txm INNER JOIN  ProductStock ps ON p.pro_id=ps.pro_id WHERE ps.warehouse_id=odp.supplierid and odp.huojiahao is null
	end

end 

select odp.* from Direct_OrderDetail  odp inner join Product p on odp.txm=p.pro_txm INNER JOIN  ProductStock ps ON p.pro_id=ps.pro_id WHERE ps.warehouse_id=odp.supplierid and (odp.huojiahao is null )
GO
/****** Object:  UserDefinedFunction [dbo].[PostFee_Compute]    Script Date: 12/04/2017 15:05:06 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[PostFee_Compute](@shopxp_shfs int,@province varchar(50),@city varchar(50),@county varchar(50))
returns @yunfei table (province varchar(50),freePostMoney real,shouzhong real,xuzhong real,souzong_yunfei real,xuzong_yunfei real,PostDateMin int,PostDateMax int)
as 
/*
以某种运输方式到某县级单位的的运费收费规则,
*/
begin
/*
declare @shopxp_shfs int,@province varchar(50),@city varchar(50),@county varchar(50)
set @shopxp_shfs=26
set @province='河北省' 
set @city='石家庄市'
set @county='鹿泉市'
*/

--不存在此省份的运费信息时,则默认为其它的运费信息

--定义存放要查询的省的临时表
declare @TempPostArea table (id int,province varchar(50),city varchar(50),county varchar(50),free_post_money real,first_weight real,Continued_Weight real,first_fee real,Continued_fee real,PostDateMin int,PostDateMax int)
if not exists(select id from Post_Freight where songid=@shopxp_shfs and  charindex(@province,province)>0)
	begin
	set @province='其它'
	set @city='0'
	set @county='0'
	end
/*
print @province
print @city
print @county
*/
--将所有此省的运费记录查出
insert into @TempPostArea(id,province,city,county,free_post_money,first_weight,Continued_Weight,first_fee,Continued_fee,PostDateMin,PostDateMax) select id,province,city,county,free_post_money,first_weight,Continued_Weight,first_fee,Continued_fee,PostDateMin,PostDateMax from Post_Freight where songid=@shopxp_shfs and charindex(@province,province)>0

--判断执行省、市、县？
declare @id int
if exists(select id from @TempPostArea where  charindex(@province,province)>0 and city=''+@city+'' and [county]=''+@county+'')--是否存在其送往地区县级单位运费设置
	begin
		select @id=id from @TempPostArea where charindex(@province,province)>0 and city=''+@city+'' and [county]=''+@county+''
	end
else
	begin
		if exists(select id from @TempPostArea where  charindex(@province,province)>0 and city=''+@city+'')--市级
			begin
				select @id=id from @TempPostArea where charindex(@province,province)>0 and city=''+@city+'' and county='0'
			end
		else--省级
			begin
				select @id=id from @TempPostArea where charindex(@province,province)>0 and city='0'  and county='0'
			end
	end
--select province,city,county,free_post_money,first_weight,Continued_Weight,first_fee,Continued_fee from @TempPostArea where id=@id

--确认送往地区的记录ID
if @id is not null
begin
insert into @yunfei(province,freePostMoney,shouzhong,xuzhong,souzong_yunfei,xuzong_yunfei,PostDateMin,PostDateMax)
select province,free_post_money,first_weight,Continued_Weight,first_fee,Continued_fee,PostDateMin,PostDateMax from @TempPostArea where id=@id
end 
return
end
GO
/****** Object:  StoredProcedure [dbo].[kou_kucun_log]    Script Date: 12/04/2017 15:05:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[kou_kucun_log]
(
/*
批量处理传入3个参数
*/
@dingdan varchar(50),--订单号
@ordermain_type int,--下单类型。1代表代理进货(包括注册，升级，带下)，2代表分销中心进货 3:免费用户下单
@shopxp_shfs int,--收获方式

/*
根据商品样式等循环处理，传入4个参数
*/
@shopxp_yangshiid int=0,
@op_user nvarchar(20)='',
@op_num int=0,
@change_type int=0,
/*
stock_lessen表调用使用
*/
@OrderIdentity int=0
)
AS

/*
作用：生成扣库存日志
作者：恐龙
调用：exec kou_kucun_log '2010100809231481','1','100004',26

修改人：sxf
功能：增加免费用户的处理,增加操作人的处理。删除传入参数：fuwu_userid
修改日期：2010-12-31
*/
BEGIN
	SET NOCOUNT ON
    declare @inst_sql varchar(1000),@kucun_type_num varchar(50)
	declare @change_type1	int --操作类型
	declare @Warehouse_id int					-- 仓库编号
	
	
	
	--$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
	if @dingdan>'' and @ordermain_type>0 and @shopxp_shfs>0
	begin

		
		if @shopxp_shfs =23
			set  @kucun_type_num='zhanting_num'
		 else
			set  @kucun_type_num='erqi_num'

	

	--获取仓库对应的ID编号
	 select @Warehouse_id=Warehouse_id from config_PostStyle  where songid=@shopxp_shfs
	 
	 
		 if @ordermain_type=1--代理
		 begin
			begin tran
			
			insert into stock_change_log(warehouse_id, shopxp_yangshiid, shiji_num_before, notpost_num_before, sunhuai_before,add_num, cart_type, op_user, userid, dingdan,change_type,isGift) select @warehouse_id,wd.shopxp_yangshiid,wd.shiji_num,wd.notpost_num,wd.sunhuai_num,os.productcount,os.cart_type,case when cart_type=1 then fuwu_userid  when cart_type in (3,4,7,8,9) then shouyin_user else userid end,os.userid,os.dingdan,cart_type,0 from  agent_Order_info  os inner join warehouse_detail wd on os.shopxp_yangshiid=wd.shopxp_yangshiid where os.dingdan=@dingdan  and wd.warehouse_id=@warehouse_id
			commit tran

			return 
		end  

         

		if @ordermain_type=2  --分销中心下单
		begin
			begin tran
			

			insert into stock_change_log(warehouse_id, shopxp_yangshiid, shiji_num_before, notpost_num_before, sunhuai_before,add_num, cart_type,change_type, op_user, userid, dingdan) select @warehouse_id,wd.shopxp_yangshiid,wd.shiji_num,wd.notpost_num,wd.sunhuai_num,os.productcount,os.cart_type,os.cart_type,case when os.cart_type in (3,4,7,8,9) then os.shouyin_user else os.userid end,os.userid,os.dingdan from  distribution_order_info  os inner join warehouse_detail wd on os.shopxp_yangshiid=wd.shopxp_yangshiid where os.dingdan=@dingdan  and wd.warehouse_id=@warehouse_id
			commit tran
			return 
		end




		 

	  



	 if @ordermain_type=7		--同城配送赠品
		 begin
			begin tran
			
			insert into stock_change_log(warehouse_id, shopxp_yangshiid, shiji_num_before, notpost_num_before, sunhuai_before,add_num, cart_type, op_user, userid, dingdan,change_type,isGift) select @warehouse_id,wd.shopxp_yangshiid,wd.shiji_num,wd.notpost_num,wd.sunhuai_num,cod.Number,71,'同城配送赠品','',@dingdan,71,0 from  City_Order_Present cod inner join warehouse_detail wd on  wd.shopxp_yangshiid=cod.ProStyleID where cod.OrderNumber=@dingdan  and wd.warehouse_id=@warehouse_id
			commit tran
			return 
		end  


	 if @ordermain_type=8	--同城取消订单
		 begin
			begin tran
			

			--插入新库存日志表	
			insert into stock_change_log(warehouse_id, shopxp_yangshiid,shiji_num_before,notpost_num_before, sunhuai_before,add_num, cart_type, op_user, userid, dingdan,change_type,isGift) select @warehouse_id,wd.shopxp_yangshiid,wd.shiji_num,wd.notpost_num,wd.sunhuai_num,cod.Number,73,'同城取消订单','',@dingdan,73,0 from  City_Order_Detail cod inner join warehouse_detail wd on wd.shopxp_yangshiid=cod.ProStyleID where cod.OrderNumber=@dingdan  and wd.warehouse_id=@warehouse_id	
			
			--插入新库存日志表	
			insert into stock_change_log(warehouse_id, shopxp_yangshiid,shiji_num_before,notpost_num_before, sunhuai_before,add_num, cart_type, op_user, userid, dingdan,change_type,isGift) select @warehouse_id,wd.shopxp_yangshiid,wd.shiji_num,wd.notpost_num,wd.sunhuai_num,cod.Number,73,'同城取消订单，增加赠品库存','',@dingdan,73,1 from   City_Order_Detail cod inner join warehouse_detail wd on wd.shopxp_yangshiid=cod.ProStyleID where cod.OrderNumber=@dingdan  and wd.warehouse_id=@warehouse_id

			commit tran
			return 
		end 

	 if @ordermain_type=9		--同城配送
		 begin
			begin tran
			--插入新库存日志表	
			insert into stock_change_log(warehouse_id, shopxp_yangshiid,shiji_num_before,notpost_num_before, sunhuai_before,add_num, cart_type, op_user, userid, dingdan,change_type,isGift) select @warehouse_id,wd.shopxp_yangshiid,wd.shiji_num,wd.notpost_num,wd.sunhuai_num,cod.Number,71,'同城配送' ,'',@dingdan,71,0 from  City_Order_Detail cod inner join warehouse_detail wd on wd.shopxp_yangshiid=cod.ProStyleID where cod.OrderNumber=@dingdan  and wd.warehouse_id=@warehouse_id
			commit tran
			return 
		end 
		
		--同城配送打单减未发#####################
		if @ordermain_type=10		
		 begin
			begin tran
			
			--插入新库存日志表	
			insert into stock_change_log(warehouse_id, shopxp_yangshiid,shiji_num_before,notpost_num_before, sunhuai_before,add_num, cart_type, op_user, userid, dingdan,change_type,isGift) select @warehouse_id,wd.shopxp_yangshiid,wd.shiji_num,wd.notpost_num,wd.sunhuai_num,cod.Number,0,'同城配送打单减未发' ,'',@dingdan,72,0 from  City_Order_Detail cod inner join warehouse_detail wd on wd.shopxp_yangshiid=cod.ProStyleID where cod.OrderNumber=@dingdan  and wd.warehouse_id=@warehouse_id
			
			
			
			--插入新库存日志表	
			insert into stock_change_log(warehouse_id, shopxp_yangshiid,shiji_num_before,notpost_num_before, sunhuai_before,add_num, cart_type, op_user, userid, dingdan,change_type,isGift) select @warehouse_id,wd.shopxp_yangshiid,wd.shiji_num,wd.notpost_num,wd.sunhuai_num,cop.Number,0,'同城配送打单减赠品未发','',@dingdan,72,1 from City_Order_Present cop inner join warehouse_detail wd on wd.shopxp_yangshiid=cop.ProStyleID where cop.OrderNumber=@dingdan  and wd.warehouse_id=@warehouse_id
			
			commit tran
			return 
		end   


 

 
 end
	--$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


	  

		--########################################################## 
		--执行原ChangeStockLog_add存储过程的操作
		if @shopxp_yangshiid>0 and @op_num>0 and @change_type>0
		begin 
		
			if  @Change_type in (13,21,23,14,22,24,33)
				set @shopxp_shfs=23

			if  @Change_type in (17,25,18,26,34)
				set @shopxp_shfs=26
				
				
			--获取仓库对应的ID编号
			 select @Warehouse_id=Warehouse_id from config_PostStyle  where songid=@shopxp_shfs	
				
			begin tran
			--展厅修正库存增加,展柜库存增加,展厅损坏库存修正增加,展厅修正库存减少,展柜库存减少,展厅损坏库存修正减少
			if  @Change_type in (13,21,23,14,22,24,33) 
			begin
				
				--插入新库存日志表
				insert into stock_change_log(warehouse_id, shopxp_yangshiid, shiji_num_before, notpost_num_before, sunhuai_before,add_num, cart_type, op_user, userid, dingdan,change_type,isGift) select @warehouse_id,wd.shopxp_yangshiid,wd.shiji_num,wd.notpost_num,wd.sunhuai_num,@op_num,0,@op_user,'','00',@Change_type,0 from warehouse_detail wd  where wd.shopxp_yangshiid=@shopxp_yangshiid  and wd.warehouse_id=@warehouse_id
				--print @warehouse_id
				--print @op_user
				--print @shopxp_yangshiid
				--print @change_type
				
			end 
		
			
		

			--大仓库修正库存增加,大仓库损坏库存修正增加,大仓库修正库存减少,大仓库损坏库存修正减少
			if  @Change_type in (17,25,18,26,34) 
			begin
				
				
				--插入新库存日志表
				insert into stock_change_log(warehouse_id, shopxp_yangshiid, shiji_num_before, notpost_num_before, sunhuai_before,add_num, cart_type, op_user, userid, dingdan,change_type,isGift) select @warehouse_id,wd.shopxp_yangshiid,wd.shiji_num,wd.notpost_num,wd.sunhuai_num,@op_num ,0,@op_user,'','01',@Change_type,0 from warehouse_detail wd  where wd.shopxp_yangshiid=@shopxp_yangshiid  and wd.warehouse_id=@warehouse_id
			end
			commit tran
			
			
		end --执行原ChangeStockLog_add存储过程的操作结束
	--########################################################## 
	

	
END
GO
/****** Object:  Default [DF_Config_PayStyle_ID]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Config_PayStyle] ADD  CONSTRAINT [DF_Config_PayStyle_ID]  DEFAULT ((0)) FOR [ID]
GO
/****** Object:  Default [DF_Config_PayStyle_songid]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Config_PayStyle] ADD  CONSTRAINT [DF_Config_PayStyle_songid]  DEFAULT ((0)) FOR [songid]
GO
/****** Object:  Default [DF_Config_PayStyle_subject]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Config_PayStyle] ADD  CONSTRAINT [DF_Config_PayStyle_subject]  DEFAULT ('') FOR [subject]
GO
/****** Object:  Default [DF_Config_PayStyle_songidorder]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Config_PayStyle] ADD  CONSTRAINT [DF_Config_PayStyle_songidorder]  DEFAULT ((0)) FOR [songidorder]
GO
/****** Object:  Default [DF_Config_PayStyle_DulyPay]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Config_PayStyle] ADD  CONSTRAINT [DF_Config_PayStyle_DulyPay]  DEFAULT ((0)) FOR [DulyPay]
GO
/****** Object:  Default [DF_Config_PostStyle_is_dis]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Config_PostStyle] ADD  CONSTRAINT [DF_Config_PostStyle_is_dis]  DEFAULT ((0)) FOR [dis_reg]
GO
/****** Object:  Default [DF_Config_PostStyle_dis_shop]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Config_PostStyle] ADD  CONSTRAINT [DF_Config_PostStyle_dis_shop]  DEFAULT ((0)) FOR [dis_shop]
GO
/****** Object:  Default [DF_Config_PostStyle_dis_fenxiaojinhuo]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Config_PostStyle] ADD  CONSTRAINT [DF_Config_PostStyle_dis_fenxiaojinhuo]  DEFAULT ((0)) FOR [dis_fenxiaojinhuo]
GO
/****** Object:  Default [DF_Config_PostStyle_dis_fenxiaosale]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Config_PostStyle] ADD  CONSTRAINT [DF_Config_PostStyle_dis_fenxiaosale]  DEFAULT ((0)) FOR [dis_fenxiaosale]
GO
/****** Object:  Default [DF_self_Order_ProDetail_shopxpptid]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderDetail] ADD  CONSTRAINT [DF_self_Order_ProDetail_shopxpptid]  DEFAULT ((0)) FOR [shopxpptid]
GO
/****** Object:  Default [DF_self_Order_ProDetail_style_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderDetail] ADD  CONSTRAINT [DF_self_Order_ProDetail_style_id]  DEFAULT ((0)) FOR [style_id]
GO
/****** Object:  Default [DF_self_Order_ProDetail_productcount]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderDetail] ADD  CONSTRAINT [DF_self_Order_ProDetail_productcount]  DEFAULT ((0)) FOR [productcount]
GO
/****** Object:  Default [DF_Direct_OrderDetail_productcount_return]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderDetail] ADD  CONSTRAINT [DF_Direct_OrderDetail_productcount_return]  DEFAULT ((0)) FOR [productcount_return]
GO
/****** Object:  Default [DF_self_Order_ProDetail_danjia]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderDetail] ADD  CONSTRAINT [DF_self_Order_ProDetail_danjia]  DEFAULT ((0)) FOR [danjia]
GO
/****** Object:  Default [DF_Direct_OrderDetail_voucher]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderDetail] ADD  CONSTRAINT [DF_Direct_OrderDetail_voucher]  DEFAULT ((0)) FOR [voucher]
GO
/****** Object:  Default [DF_Direct_OrderDetail_JiFen]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderDetail] ADD  CONSTRAINT [DF_Direct_OrderDetail_JiFen]  DEFAULT ((0)) FOR [JiFen]
GO
/****** Object:  Default [DF_Direct_OrderDetail_StorageSortId]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderDetail] ADD  CONSTRAINT [DF_Direct_OrderDetail_StorageSortId]  DEFAULT ((0)) FOR [StorageSortId]
GO
/****** Object:  Default [DF_Direct_OrderDetail_area_number]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderDetail] ADD  CONSTRAINT [DF_Direct_OrderDetail_area_number]  DEFAULT ((0)) FOR [area_number]
GO
/****** Object:  Default [DF_Direct_OrderDetail_return_order_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderDetail] ADD  CONSTRAINT [DF_Direct_OrderDetail_return_order_id]  DEFAULT ((0)) FOR [return_detail_id]
GO
/****** Object:  Default [DF_Direct_OrderMainuserid]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderMain] ADD  CONSTRAINT [DF_Direct_OrderMainuserid]  DEFAULT ((0)) FOR [userid]
GO
/****** Object:  Default [DF_Direct_OrderMain_user_name]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderMain] ADD  CONSTRAINT [DF_Direct_OrderMain_user_name]  DEFAULT ('') FOR [user_name]
GO
/****** Object:  Default [DF_Direct_OrderMain_store_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderMain] ADD  CONSTRAINT [DF_Direct_OrderMain_store_id]  DEFAULT ((0)) FOR [store_id]
GO
/****** Object:  Default [DF_Direct_OrderMain_warehouse_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderMain] ADD  CONSTRAINT [DF_Direct_OrderMain_warehouse_id]  DEFAULT ((0)) FOR [warehouse_id]
GO
/****** Object:  Default [DF_Direct_OrderMain_order_amount]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderMain] ADD  CONSTRAINT [DF_Direct_OrderMain_order_amount]  DEFAULT ((0)) FOR [order_amount]
GO
/****** Object:  Default [DF_Direct_OrderMain_order_plus]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderMain] ADD  CONSTRAINT [DF_Direct_OrderMain_order_plus]  DEFAULT ((0)) FOR [order_plus]
GO
/****** Object:  Default [DF_self_Order_Main_freight]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderMain] ADD  CONSTRAINT [DF_self_Order_Main_freight]  DEFAULT ((0)) FOR [freight]
GO
/****** Object:  Default [DF_self_Order_Main_fapiao]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderMain] ADD  CONSTRAINT [DF_self_Order_Main_fapiao]  DEFAULT ((0)) FOR [fapiao]
GO
/****** Object:  Default [DF_self_Order_Main_shopxp_shfs]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderMain] ADD  CONSTRAINT [DF_self_Order_Main_shopxp_shfs]  DEFAULT ((0)) FOR [shopxp_shfs]
GO
/****** Object:  Default [DF_Direct_OrderMain_payment_name]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderMain] ADD  CONSTRAINT [DF_Direct_OrderMain_payment_name]  DEFAULT ('') FOR [payment_name]
GO
/****** Object:  Default [DF_Direct_OrderMain_zhuangtai]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderMain] ADD  CONSTRAINT [DF_Direct_OrderMain_zhuangtai]  DEFAULT ((1)) FOR [zhuangtai]
GO
/****** Object:  Default [DF_self_Order_Main_add_time]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderMain] ADD  CONSTRAINT [DF_self_Order_Main_add_time]  DEFAULT (getdate()) FOR [add_date]
GO
/****** Object:  Default [DF_Direct_OrderMain_ShippingCompany]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderMain] ADD  CONSTRAINT [DF_Direct_OrderMain_ShippingCompany]  DEFAULT ('') FOR [ShippingCompany]
GO
/****** Object:  Default [DF_Direct_OrderMain_isTiaohuo]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderMain] ADD  CONSTRAINT [DF_Direct_OrderMain_isTiaohuo]  DEFAULT ((0)) FOR [is_tiaohuan]
GO
/****** Object:  Default [DF_Direct_OrderMain_return_order_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderMain] ADD  CONSTRAINT [DF_Direct_OrderMain_return_order_id]  DEFAULT ((0)) FOR [return_order_id]
GO
/****** Object:  Default [DF__Direct_Or__isPay__02D256E1]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderMain] ADD  CONSTRAINT [DF__Direct_Or__isPay__02D256E1]  DEFAULT ((1)) FOR [isPay]
GO
/****** Object:  Default [DF_Direct_OrderMain_guide_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderMain] ADD  CONSTRAINT [DF_Direct_OrderMain_guide_id]  DEFAULT ((0)) FOR [guide_id]
GO
/****** Object:  Default [DF_Direct_OrderMain_cashier_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Direct_OrderMain] ADD  CONSTRAINT [DF_Direct_OrderMain_cashier_id]  DEFAULT ((0)) FOR [cashier_id]
GO
/****** Object:  Default [DF_GoodsPositionSet_AddTime]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[GoodsPositionSet] ADD  CONSTRAINT [DF_GoodsPositionSet_AddTime]  DEFAULT (getdate()) FOR [AddTime]
GO
/****** Object:  Default [DF_liushuihao_churukuhao]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[liushuihao] ADD  CONSTRAINT [DF_liushuihao_churukuhao]  DEFAULT ((0)) FOR [churukuhao]
GO
/****** Object:  Default [DF_liushuihao_WorkingSn]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[liushuihao] ADD  CONSTRAINT [DF_liushuihao_WorkingSn]  DEFAULT ((0)) FOR [WorkingSn]
GO
/****** Object:  Default [DF_LogVpn_Operator]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[LogVpn] ADD  CONSTRAINT [DF_LogVpn_Operator]  DEFAULT ('') FOR [Operator]
GO
/****** Object:  Default [DF_LogVpn_AddTime]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[LogVpn] ADD  CONSTRAINT [DF_LogVpn_AddTime]  DEFAULT (getdate()) FOR [AddTime]
GO
/****** Object:  Default [DF_LogVpn_DoType]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[LogVpn] ADD  CONSTRAINT [DF_LogVpn_DoType]  DEFAULT ('') FOR [DoType]
GO
/****** Object:  Default [DF_LogVpn_DoUrl]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[LogVpn] ADD  CONSTRAINT [DF_LogVpn_DoUrl]  DEFAULT ('') FOR [DoUrl]
GO
/****** Object:  Default [DF_LogVpn_DoWhat]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[LogVpn] ADD  CONSTRAINT [DF_LogVpn_DoWhat]  DEFAULT ('') FOR [DoWhat]
GO
/****** Object:  Default [DF_LogVpn_objectId]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[LogVpn] ADD  CONSTRAINT [DF_LogVpn_objectId]  DEFAULT ((0)) FOR [objectId]
GO
/****** Object:  Default [DF_Order_States_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Order_States] ADD  CONSTRAINT [DF_Order_States_id]  DEFAULT ((0)) FOR [id]
GO
/****** Object:  Default [DF_Order_States_add_date]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Order_States] ADD  CONSTRAINT [DF_Order_States_add_date]  DEFAULT (getdate()) FOR [add_date]
GO
/****** Object:  Default [DF_Post_Freight_First_Weight]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Post_Freight] ADD  CONSTRAINT [DF_Post_Freight_First_Weight]  DEFAULT ((1)) FOR [First_Weight]
GO
/****** Object:  Default [DF_Post_Freight_Continued_Weight]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Post_Freight] ADD  CONSTRAINT [DF_Post_Freight_Continued_Weight]  DEFAULT ((1)) FOR [Continued_Weight]
GO
/****** Object:  Default [DF_Post_Freight_First_Feei]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Post_Freight] ADD  CONSTRAINT [DF_Post_Freight_First_Feei]  DEFAULT ((20)) FOR [First_Fee]
GO
/****** Object:  Default [DF_Post_Freight_PostDate_1]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Post_Freight] ADD  CONSTRAINT [DF_Post_Freight_PostDate_1]  DEFAULT ((1)) FOR [PostDateMin]
GO
/****** Object:  Default [DF_Post_Freight_PostDateMax]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Post_Freight] ADD  CONSTRAINT [DF_Post_Freight_PostDateMax]  DEFAULT ((1)) FOR [PostDateMax]
GO
/****** Object:  Default [DF_Product_pm_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_pm_id]  DEFAULT ((0)) FOR [pm_id]
GO
/****** Object:  Default [DF_Product_sys_date]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_sys_date]  DEFAULT (getdate()) FOR [sys_date]
GO
/****** Object:  Default [DF_Product_pro_txm]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_pro_txm]  DEFAULT ('') FOR [pro_txm]
GO
/****** Object:  Default [DF_Product_pro_inprice]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_pro_inprice]  DEFAULT ((0)) FOR [pro_inprice]
GO
/****** Object:  Default [DF_Product_pro_inprice_tax]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_pro_inprice_tax]  DEFAULT ((0)) FOR [pro_inprice_tax]
GO
/****** Object:  Default [DF_Product_pro_price]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_pro_price]  DEFAULT ((0)) FOR [pro_price]
GO
/****** Object:  Default [DF_Product_pro_marketprice]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_pro_marketprice]  DEFAULT ((0)) FOR [pro_marketprice]
GO
/****** Object:  Default [DF_Product_pro_outprice]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_pro_outprice]  DEFAULT ((0)) FOR [pro_outprice]
GO
/****** Object:  Default [DF_Product_pro_outprice_advanced]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_pro_outprice_advanced]  DEFAULT ((0)) FOR [pro_outprice_advanced]
GO
/****** Object:  Default [DF_Product_pro_settleprice]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_pro_settleprice]  DEFAULT ((0)) FOR [pro_settleprice]
GO
/****** Object:  Default [DF_Product_ecm_specid]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_ecm_specid]  DEFAULT ((0)) FOR [ecm_specid]
GO
/****** Object:  Default [DF_ProductMain_sys_date]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductMain] ADD  CONSTRAINT [DF_ProductMain_sys_date]  DEFAULT (getdate()) FOR [sys_date]
GO
/****** Object:  Default [DF_ProductMain_type_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductMain] ADD  CONSTRAINT [DF_ProductMain_type_id]  DEFAULT ((0)) FOR [type_id]
GO
/****** Object:  Default [DF_ProductMain_pro_name]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductMain] ADD  CONSTRAINT [DF_ProductMain_pro_name]  DEFAULT ('') FOR [pro_name]
GO
/****** Object:  Default [DF_ProductMain_pro_supplierid]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductMain] ADD  CONSTRAINT [DF_ProductMain_pro_supplierid]  DEFAULT ((0)) FOR [pro_supplierid]
GO
/****** Object:  Default [DF_ProductMain_spec_name_1]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductMain] ADD  CONSTRAINT [DF_ProductMain_spec_name_1]  DEFAULT (N'颜色') FOR [spec_name_1]
GO
/****** Object:  Default [DF_ProductMain_spec_name_2]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductMain] ADD  CONSTRAINT [DF_ProductMain_spec_name_2]  DEFAULT (N'型号') FOR [spec_name_2]
GO
/****** Object:  Default [DF_ProductMain_pro_pym]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductMain] ADD  CONSTRAINT [DF_ProductMain_pro_pym]  DEFAULT ('') FOR [pro_pym]
GO
/****** Object:  Default [DF_ProductMain_pro_unit]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductMain] ADD  CONSTRAINT [DF_ProductMain_pro_unit]  DEFAULT ('') FOR [pro_unit]
GO
/****** Object:  Default [DF_ProductMain_sys_del]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductMain] ADD  CONSTRAINT [DF_ProductMain_sys_del]  DEFAULT ((0)) FOR [sys_del]
GO
/****** Object:  Default [DF_ProductMain_used_flag]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductMain] ADD  CONSTRAINT [DF_ProductMain_used_flag]  DEFAULT ((0)) FOR [used_flag]
GO
/****** Object:  Default [DF_ProductMain_kc_flag]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductMain] ADD  CONSTRAINT [DF_ProductMain_kc_flag]  DEFAULT ((0)) FOR [kc_flag]
GO
/****** Object:  Default [DF_ProductStock_pm_id_1]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductStock] ADD  CONSTRAINT [DF_ProductStock_pm_id_1]  DEFAULT ((0)) FOR [pm_id]
GO
/****** Object:  Default [DF_ProductStock_pro_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductStock] ADD  CONSTRAINT [DF_ProductStock_pro_id]  DEFAULT ((0)) FOR [pro_id]
GO
/****** Object:  Default [DF_ProductStock_warehouse_id_1]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductStock] ADD  CONSTRAINT [DF_ProductStock_warehouse_id_1]  DEFAULT ((0)) FOR [warehouse_id]
GO
/****** Object:  Default [DF_ProductStock_in_nums_1]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductStock] ADD  CONSTRAINT [DF_ProductStock_in_nums_1]  DEFAULT ((0)) FOR [in_nums]
GO
/****** Object:  Default [DF_ProductStock_out_nums_1]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductStock] ADD  CONSTRAINT [DF_ProductStock_out_nums_1]  DEFAULT ((0)) FOR [out_nums]
GO
/****** Object:  Default [DF_ProductStock_kc_nums_1]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductStock] ADD  CONSTRAINT [DF_ProductStock_kc_nums_1]  DEFAULT ((0)) FOR [kc_nums]
GO
/****** Object:  Default [DF_ProductStock_do_nums]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductStock] ADD  CONSTRAINT [DF_ProductStock_do_nums]  DEFAULT ((0)) FOR [do_nums]
GO
/****** Object:  Default [DF_ProductStock_add_time_1]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductStock] ADD  CONSTRAINT [DF_ProductStock_add_time_1]  DEFAULT (getdate()) FOR [add_time]
GO
/****** Object:  Default [DF_ProductStock_update_time_1]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductStock] ADD  CONSTRAINT [DF_ProductStock_update_time_1]  DEFAULT (getdate()) FOR [update_time]
GO
/****** Object:  Default [DF_ProductStock_kc_flag_1]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductStock] ADD  CONSTRAINT [DF_ProductStock_kc_flag_1]  DEFAULT ((0)) FOR [kc_flag]
GO
/****** Object:  Default [DF_ProductStock_shelf_no_1]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductStock] ADD  CONSTRAINT [DF_ProductStock_shelf_no_1]  DEFAULT ('') FOR [shelf_no]
GO
/****** Object:  Default [DF_ProductStock_stock_price]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductStock] ADD  CONSTRAINT [DF_ProductStock_stock_price]  DEFAULT ((0)) FOR [stock_price]
GO
/****** Object:  Default [DF_ProductType_type_name]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductType] ADD  CONSTRAINT [DF_ProductType_type_name]  DEFAULT ('') FOR [type_name]
GO
/****** Object:  Default [DF_ProductType_sort_order]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductType] ADD  CONSTRAINT [DF_ProductType_sort_order]  DEFAULT ((0)) FOR [sort_order]
GO
/****** Object:  Default [DF_ProductType_add_time]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductType] ADD  CONSTRAINT [DF_ProductType_add_time]  DEFAULT (getdate()) FOR [add_time]
GO
/****** Object:  Default [DF_ProductType_type_remark]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductType] ADD  CONSTRAINT [DF_ProductType_type_remark]  DEFAULT ('') FOR [type_remark]
GO
/****** Object:  Default [DF_ProductType_is_hide]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[ProductType] ADD  CONSTRAINT [DF_ProductType_is_hide]  DEFAULT ((0)) FOR [is_hide]
GO
/****** Object:  Default [DF_SinoModule_ID]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[SinoModule] ADD  CONSTRAINT [DF_SinoModule_ID]  DEFAULT ((0)) FOR [ID]
GO
/****** Object:  Default [DF_SinoModule_PageUrl]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[SinoModule] ADD  CONSTRAINT [DF_SinoModule_PageUrl]  DEFAULT ('') FOR [PageUrl]
GO
/****** Object:  Default [DF_SinoModule_OrderNum]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[SinoModule] ADD  CONSTRAINT [DF_SinoModule_OrderNum]  DEFAULT ((0)) FOR [OrderNum]
GO
/****** Object:  Default [DF_SinoModule_IsShow]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[SinoModule] ADD  CONSTRAINT [DF_SinoModule_IsShow]  DEFAULT ((0)) FOR [IsShow]
GO
/****** Object:  Default [DF_SinoModule_PID]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[SinoModule] ADD  CONSTRAINT [DF_SinoModule_PID]  DEFAULT ((0)) FOR [PID]
GO
/****** Object:  Default [DF_SinoRole_ID]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[SinoRole] ADD  CONSTRAINT [DF_SinoRole_ID]  DEFAULT ((0)) FOR [ID]
GO
/****** Object:  Default [DF_SinoRole_RoleName]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[SinoRole] ADD  CONSTRAINT [DF_SinoRole_RoleName]  DEFAULT ('') FOR [RoleName]
GO
/****** Object:  Default [DF_SinoRole_CreateTime]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[SinoRole] ADD  CONSTRAINT [DF_SinoRole_CreateTime]  DEFAULT (getdate()) FOR [CreateTime]
GO
/****** Object:  Default [DF_SinoRole_UpdateTime]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[SinoRole] ADD  CONSTRAINT [DF_SinoRole_UpdateTime]  DEFAULT (getdate()) FOR [UpdateTime]
GO
/****** Object:  Default [DF_SinoRole_isAgent]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[SinoRole] ADD  CONSTRAINT [DF_SinoRole_isAgent]  DEFAULT ((0)) FOR [isAgent]
GO
/****** Object:  Default [DF_SinoRoleModule_PowerStr]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[SinoRoleModule] ADD  CONSTRAINT [DF_SinoRoleModule_PowerStr]  DEFAULT ((0)) FOR [PowerStr]
GO
/****** Object:  Default [DF_SinoRoleModule_AddTime]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[SinoRoleModule] ADD  CONSTRAINT [DF_SinoRoleModule_AddTime]  DEFAULT (getdate()) FOR [AddTime]
GO
/****** Object:  Default [DF_supplier_leijijiner_1]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[supplier] ADD  CONSTRAINT [DF_supplier_leijijiner_1]  DEFAULT ((0)) FOR [leijijiner]
GO
/****** Object:  Default [DF_supplier_weijiejiner_1]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[supplier] ADD  CONSTRAINT [DF_supplier_weijiejiner_1]  DEFAULT ((0)) FOR [weijiejiner]
GO
/****** Object:  Default [DF_supplier_wuliushijian]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[supplier] ADD  CONSTRAINT [DF_supplier_wuliushijian]  DEFAULT ((0)) FOR [wuliushijian]
GO
/****** Object:  Default [DF_supplier_add_date]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[supplier] ADD  CONSTRAINT [DF_supplier_add_date]  DEFAULT (getdate()) FOR [add_date]
GO
/****** Object:  Default [DF_supplier_IsLock]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[supplier] ADD  CONSTRAINT [DF_supplier_IsLock]  DEFAULT ((0)) FOR [IsLock]
GO
/****** Object:  Default [DF_supplier_IsFactory]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[supplier] ADD  CONSTRAINT [DF_supplier_IsFactory]  DEFAULT ((0)) FOR [IsFactory]
GO
/****** Object:  Default [DF_Tb_Agent_Agent_name]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_Agent] ADD  CONSTRAINT [DF_Tb_Agent_Agent_name]  DEFAULT ('') FOR [Agent_name]
GO
/****** Object:  Default [DF_Tb_Agent_is_hide]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_Agent] ADD  CONSTRAINT [DF_Tb_Agent_is_hide]  DEFAULT ((0)) FOR [is_hide]
GO
/****** Object:  Default [DF_Tb_Agent_add_time]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_Agent] ADD  CONSTRAINT [DF_Tb_Agent_add_time]  DEFAULT (getdate()) FOR [add_time]
GO
/****** Object:  Default [DF_Tb_brand_brand_name]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_brand] ADD  CONSTRAINT [DF_Tb_brand_brand_name]  DEFAULT ('') FOR [brand_name]
GO
/****** Object:  Default [DF_Tb_brand_add_time]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_brand] ADD  CONSTRAINT [DF_Tb_brand_add_time]  DEFAULT (getdate()) FOR [add_time]
GO
/****** Object:  Default [DF_Tb_brand_is_hide]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_brand] ADD  CONSTRAINT [DF_Tb_brand_is_hide]  DEFAULT ((0)) FOR [is_hide]
GO
/****** Object:  Default [DF_Tb_cashier_cart_cashier_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_cashier_cart] ADD  CONSTRAINT [DF_Tb_cashier_cart_cashier_id]  DEFAULT ((0)) FOR [cashier_id]
GO
/****** Object:  Default [DF_Tb_cashier_cart_trace_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_cashier_cart] ADD  CONSTRAINT [DF_Tb_cashier_cart_trace_id]  DEFAULT ((0)) FOR [trace_id]
GO
/****** Object:  Default [DF_Tb_cashier_cart_store_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_cashier_cart] ADD  CONSTRAINT [DF_Tb_cashier_cart_store_id]  DEFAULT ((0)) FOR [store_id]
GO
/****** Object:  Default [DF_Tb_cashier_cart_txm]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_cashier_cart] ADD  CONSTRAINT [DF_Tb_cashier_cart_txm]  DEFAULT ('') FOR [txm]
GO
/****** Object:  Default [DF_Tb_cashier_cart_goods_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_cashier_cart] ADD  CONSTRAINT [DF_Tb_cashier_cart_goods_id]  DEFAULT ((0)) FOR [goods_id]
GO
/****** Object:  Default [DF_Tb_cashier_cart_goods_name]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_cashier_cart] ADD  CONSTRAINT [DF_Tb_cashier_cart_goods_name]  DEFAULT ('') FOR [goods_name]
GO
/****** Object:  Default [DF_Tb_cashier_cart_spec_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_cashier_cart] ADD  CONSTRAINT [DF_Tb_cashier_cart_spec_id]  DEFAULT ((0)) FOR [spec_id]
GO
/****** Object:  Default [DF_Tb_cashier_cart_specification]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_cashier_cart] ADD  CONSTRAINT [DF_Tb_cashier_cart_specification]  DEFAULT ('') FOR [specification]
GO
/****** Object:  Default [DF_Tb_cashier_cart_price]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_cashier_cart] ADD  CONSTRAINT [DF_Tb_cashier_cart_price]  DEFAULT ((0)) FOR [price]
GO
/****** Object:  Default [DF_Tb_cashier_cart_voucher_price]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_cashier_cart] ADD  CONSTRAINT [DF_Tb_cashier_cart_voucher_price]  DEFAULT ((0)) FOR [voucher_price]
GO
/****** Object:  Default [DF_Tb_cashier_cart_quantity]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_cashier_cart] ADD  CONSTRAINT [DF_Tb_cashier_cart_quantity]  DEFAULT ((0)) FOR [quantity]
GO
/****** Object:  Default [DF_Tb_cashier_cart_goods_image]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_cashier_cart] ADD  CONSTRAINT [DF_Tb_cashier_cart_goods_image]  DEFAULT ('') FOR [goods_image]
GO
/****** Object:  Default [DF_Tb_cashier_cart_is_return]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_cashier_cart] ADD  CONSTRAINT [DF_Tb_cashier_cart_is_return]  DEFAULT ((0)) FOR [is_return]
GO
/****** Object:  Default [DF_Tb_cashier_cart_order_goods_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_cashier_cart] ADD  CONSTRAINT [DF_Tb_cashier_cart_order_goods_id]  DEFAULT ((0)) FOR [order_goods_id]
GO
/****** Object:  Default [DF_Tb_ChangeStockRecord_warehouse_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_ChangeStockRecord] ADD  CONSTRAINT [DF_Tb_ChangeStockRecord_warehouse_id]  DEFAULT ((0)) FOR [warehouse_id]
GO
/****** Object:  Default [DF_Tb_ChangeStockRecord_pro_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_ChangeStockRecord] ADD  CONSTRAINT [DF_Tb_ChangeStockRecord_pro_id]  DEFAULT ((0)) FOR [pro_id]
GO
/****** Object:  Default [DF_Tb_ChangeStockRecord_change_type]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_ChangeStockRecord] ADD  CONSTRAINT [DF_Tb_ChangeStockRecord_change_type]  DEFAULT ((0)) FOR [change_type]
GO
/****** Object:  Default [DF_Tb_ChangeStockRecord_quantity]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_ChangeStockRecord] ADD  CONSTRAINT [DF_Tb_ChangeStockRecord_quantity]  DEFAULT ((0)) FOR [quantity]
GO
/****** Object:  Default [DF_Tb_ChangeStockRecord_old_num]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_ChangeStockRecord] ADD  CONSTRAINT [DF_Tb_ChangeStockRecord_old_num]  DEFAULT ((0)) FOR [old_num]
GO
/****** Object:  Default [DF_Tb_ChangeStockRecord_new_num]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_ChangeStockRecord] ADD  CONSTRAINT [DF_Tb_ChangeStockRecord_new_num]  DEFAULT ((0)) FOR [new_num]
GO
/****** Object:  Default [DF_Tb_ChangeStockRecord_change_time]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_ChangeStockRecord] ADD  CONSTRAINT [DF_Tb_ChangeStockRecord_change_time]  DEFAULT (getdate()) FOR [change_time]
GO
/****** Object:  Default [DF_Tb_check_detail_check_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_check_detail] ADD  CONSTRAINT [DF_Tb_check_detail_check_id]  DEFAULT ((0)) FOR [main_id]
GO
/****** Object:  Default [DF_Tb_check_detail_pro_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_check_detail] ADD  CONSTRAINT [DF_Tb_check_detail_pro_id]  DEFAULT ((0)) FOR [pro_id]
GO
/****** Object:  Default [DF_Tb_check_detail_pro_txm]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_check_detail] ADD  CONSTRAINT [DF_Tb_check_detail_pro_txm]  DEFAULT ('') FOR [pro_txm]
GO
/****** Object:  Default [DF_Tb_check_detail_kc_num]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_check_detail] ADD  CONSTRAINT [DF_Tb_check_detail_kc_num]  DEFAULT ((0)) FOR [kc_num]
GO
/****** Object:  Default [DF_Tb_check_detail_check_num]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_check_detail] ADD  CONSTRAINT [DF_Tb_check_detail_check_num]  DEFAULT ((0)) FOR [check_num]
GO
/****** Object:  Default [DF_Tb_check_detail_add_time]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_check_detail] ADD  CONSTRAINT [DF_Tb_check_detail_add_time]  DEFAULT (getdate()) FOR [add_time]
GO
/****** Object:  Default [DF_Tb_check_input_main_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_check_input] ADD  CONSTRAINT [DF_Tb_check_input_main_id]  DEFAULT ((0)) FOR [main_id]
GO
/****** Object:  Default [DF_Tb_check_input_pro_txm]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_check_input] ADD  CONSTRAINT [DF_Tb_check_input_pro_txm]  DEFAULT ('') FOR [pro_txm]
GO
/****** Object:  Default [DF_Tb_check_input_check_num]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_check_input] ADD  CONSTRAINT [DF_Tb_check_input_check_num]  DEFAULT ((0)) FOR [check_num]
GO
/****** Object:  Default [DF_Tb_check_input_area_code]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_check_input] ADD  CONSTRAINT [DF_Tb_check_input_area_code]  DEFAULT ('') FOR [area_code]
GO
/****** Object:  Default [DF_Tb_check_main_check_sn]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_check_main] ADD  CONSTRAINT [DF_Tb_check_main_check_sn]  DEFAULT ('') FOR [check_sn]
GO
/****** Object:  Default [DF_Tb_check_main_warehouse_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_check_main] ADD  CONSTRAINT [DF_Tb_check_main_warehouse_id]  DEFAULT ((0)) FOR [warehouse_id]
GO
/****** Object:  Default [DF_Tb_check_main_add_time]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_check_main] ADD  CONSTRAINT [DF_Tb_check_main_add_time]  DEFAULT (getdate()) FOR [add_time]
GO
/****** Object:  Default [DF_Tb_check_main_update_time]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_check_main] ADD  CONSTRAINT [DF_Tb_check_main_update_time]  DEFAULT (getdate()) FOR [update_time]
GO
/****** Object:  Default [DF_Tb_check_main_operator_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_check_main] ADD  CONSTRAINT [DF_Tb_check_main_operator_id]  DEFAULT ((0)) FOR [operator_id]
GO
/****** Object:  Default [DF_Tb_Factory_FactoryName]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_Factory_del] ADD  CONSTRAINT [DF_Tb_Factory_FactoryName]  DEFAULT ('') FOR [FactoryName]
GO
/****** Object:  Default [DF_Tb_Factory_AddTime]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_Factory_del] ADD  CONSTRAINT [DF_Tb_Factory_AddTime]  DEFAULT (getdate()) FOR [AddTime]
GO
/****** Object:  Default [DF_Tb_Factory_IsLock]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_Factory_del] ADD  CONSTRAINT [DF_Tb_Factory_IsLock]  DEFAULT ((0)) FOR [IsLock]
GO
/****** Object:  Default [DF_Tb_FinancialFlow_sm_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_FinancialFlow] ADD  CONSTRAINT [DF_Tb_FinancialFlow_sm_id]  DEFAULT ((0)) FOR [sm_id]
GO
/****** Object:  Default [DF_Tb_FinancialFlow_pay_money]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_FinancialFlow] ADD  CONSTRAINT [DF_Tb_FinancialFlow_pay_money]  DEFAULT ((0)) FOR [pay_money]
GO
/****** Object:  Default [DF_Tb_FinancialFlow_add_time]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_FinancialFlow] ADD  CONSTRAINT [DF_Tb_FinancialFlow_add_time]  DEFAULT (getdate()) FOR [add_time]
GO
/****** Object:  Default [DF_Tb_FinancialFlow_admin_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_FinancialFlow] ADD  CONSTRAINT [DF_Tb_FinancialFlow_admin_id]  DEFAULT ((0)) FOR [admin_id]
GO
/****** Object:  Default [DF_Tb_FinancialFlow_pay_worker]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_FinancialFlow] ADD  CONSTRAINT [DF_Tb_FinancialFlow_pay_worker]  DEFAULT ('') FOR [pay_worker]
GO
/****** Object:  Default [DF_Tb_FinancialFlow_receive_worker]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_FinancialFlow] ADD  CONSTRAINT [DF_Tb_FinancialFlow_receive_worker]  DEFAULT ('') FOR [receive_worker]
GO
/****** Object:  Default [DF_Tb_FinancialFlow_is_cancel]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_FinancialFlow] ADD  CONSTRAINT [DF_Tb_FinancialFlow_is_cancel]  DEFAULT ((0)) FOR [is_cancel]
GO
/****** Object:  Default [DF_TB_GoodsReturn_ProductCount]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[TB_GoodsReturn] ADD  CONSTRAINT [DF_TB_GoodsReturn_ProductCount]  DEFAULT ((1)) FOR [ProductCount]
GO
/****** Object:  Default [DF_TB_GoodsReturn_AddTime]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[TB_GoodsReturn] ADD  CONSTRAINT [DF_TB_GoodsReturn_AddTime]  DEFAULT (getdate()) FOR [AddTime]
GO
/****** Object:  Default [DF_TB_GoodsReturn_Status]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[TB_GoodsReturn] ADD  CONSTRAINT [DF_TB_GoodsReturn_Status]  DEFAULT ((0)) FOR [Status]
GO
/****** Object:  Default [DF_TB_GoodsReturn_GoodsFrom]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[TB_GoodsReturn] ADD  CONSTRAINT [DF_TB_GoodsReturn_GoodsFrom]  DEFAULT ((0)) FOR [GoodsFrom]
GO
/****** Object:  Default [DF_TB_GoodsReturn_OrderType]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[TB_GoodsReturn] ADD  CONSTRAINT [DF_TB_GoodsReturn_OrderType]  DEFAULT ((0)) FOR [OrderType]
GO
/****** Object:  Default [DF_TB_GoodsReturn_ChangeFlag]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[TB_GoodsReturn] ADD  CONSTRAINT [DF_TB_GoodsReturn_ChangeFlag]  DEFAULT ((0)) FOR [ChangeFlag]
GO
/****** Object:  Default [DF_TB_GoodsReturnOrder_AddTime]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[TB_GoodsReturnOrder] ADD  CONSTRAINT [DF_TB_GoodsReturnOrder_AddTime]  DEFAULT (getdate()) FOR [AddTime]
GO
/****** Object:  Default [DF_TB_GoodsReturnOrder_OrderStatus]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[TB_GoodsReturnOrder] ADD  CONSTRAINT [DF_TB_GoodsReturnOrder_OrderStatus]  DEFAULT ((0)) FOR [OrderStatus]
GO
/****** Object:  Default [DF_Tb_GoodsReturnReson_typeSort]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_GoodsReturnReson] ADD  CONSTRAINT [DF_Tb_GoodsReturnReson_typeSort]  DEFAULT ((0)) FOR [typeSort]
GO
/****** Object:  Default [DF_Tb_GoodsReturnReson_isHidden]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_GoodsReturnReson] ADD  CONSTRAINT [DF_Tb_GoodsReturnReson_isHidden]  DEFAULT ((0)) FOR [isHidden]
GO
/****** Object:  Default [DF_Tb_GoodsReturnReson_addTime]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_GoodsReturnReson] ADD  CONSTRAINT [DF_Tb_GoodsReturnReson_addTime]  DEFAULT (getdate()) FOR [addTime]
GO
/****** Object:  Default [DF_Tb_guide_staff_store_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_guide_staff] ADD  CONSTRAINT [DF_Tb_guide_staff_store_id]  DEFAULT ((0)) FOR [store_id]
GO
/****** Object:  Default [DF_Tb_guide_staff_guide_name]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_guide_staff] ADD  CONSTRAINT [DF_Tb_guide_staff_guide_name]  DEFAULT ('') FOR [guide_name]
GO
/****** Object:  Default [DF_Tb_guide_staff_add_time]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_guide_staff] ADD  CONSTRAINT [DF_Tb_guide_staff_add_time]  DEFAULT (getdate()) FOR [add_time]
GO
/****** Object:  Default [DF_Tb_guide_staff_is_hide]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_guide_staff] ADD  CONSTRAINT [DF_Tb_guide_staff_is_hide]  DEFAULT ((0)) FOR [is_hide]
GO
/****** Object:  Default [DF_Tb_guide_staff_guide_remark]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_guide_staff] ADD  CONSTRAINT [DF_Tb_guide_staff_guide_remark]  DEFAULT ('') FOR [guide_remark]
GO
/****** Object:  Default [DF_Tb_need_main_sm_type]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_main] ADD  CONSTRAINT [DF_Tb_need_main_sm_type]  DEFAULT ((0)) FOR [sm_type]
GO
/****** Object:  Default [DF_Tb_need_main_sm_sn]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_main] ADD  CONSTRAINT [DF_Tb_need_main_sm_sn]  DEFAULT ('') FOR [sm_sn]
GO
/****** Object:  Default [DF_Tb_need_main_warehouse_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_main] ADD  CONSTRAINT [DF_Tb_need_main_warehouse_id]  DEFAULT ((1)) FOR [warehouse_id]
GO
/****** Object:  Default [DF_Tb_need_main_warehouse_id_from]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_main] ADD  CONSTRAINT [DF_Tb_need_main_warehouse_id_from]  DEFAULT ((0)) FOR [warehouse_id_from]
GO
/****** Object:  Default [DF_Tb_need_main_sm_supplierid]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_main] ADD  CONSTRAINT [DF_Tb_need_main_sm_supplierid]  DEFAULT ((0)) FOR [sm_supplierid]
GO
/****** Object:  Default [DF_Tb_need_main_sm_supplier]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_main] ADD  CONSTRAINT [DF_Tb_need_main_sm_supplier]  DEFAULT ('') FOR [sm_supplier]
GO
/****** Object:  Default [DF_Tb_need_main_sm_date]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_main] ADD  CONSTRAINT [DF_Tb_need_main_sm_date]  DEFAULT (getdate()) FOR [sm_date]
GO
/****** Object:  Default [DF_Tb_need_main_sm_operator]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_main] ADD  CONSTRAINT [DF_Tb_need_main_sm_operator]  DEFAULT ('') FOR [sm_operator]
GO
/****** Object:  Default [DF_Tb_need_main_add_time]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_main] ADD  CONSTRAINT [DF_Tb_need_main_add_time]  DEFAULT (getdate()) FOR [add_time]
GO
/****** Object:  Default [DF_Tb_need_main_sm_status]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_main] ADD  CONSTRAINT [DF_Tb_need_main_sm_status]  DEFAULT ((0)) FOR [sm_status]
GO
/****** Object:  Default [DF_Tb_need_main_sm_adminid]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_main] ADD  CONSTRAINT [DF_Tb_need_main_sm_adminid]  DEFAULT ((0)) FOR [sm_adminid]
GO
/****** Object:  Default [DF_Tb_need_main_sm_verify_adminid]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_main] ADD  CONSTRAINT [DF_Tb_need_main_sm_verify_adminid]  DEFAULT ((0)) FOR [sm_verify_adminid]
GO
/****** Object:  Default [DF_Tb_need_product_pro_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_product] ADD  CONSTRAINT [DF_Tb_need_product_pro_id]  DEFAULT ((0)) FOR [pro_id]
GO
/****** Object:  Default [DF_Tb_need_product_sm_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_product] ADD  CONSTRAINT [DF_Tb_need_product_sm_id]  DEFAULT ((0)) FOR [sm_id]
GO
/****** Object:  Default [DF_Tb_need_product_sku_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_product] ADD  CONSTRAINT [DF_Tb_need_product_sku_id]  DEFAULT ((0)) FOR [sku_id]
GO
/****** Object:  Default [DF_Tb_need_product_p_name]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_product] ADD  CONSTRAINT [DF_Tb_need_product_p_name]  DEFAULT ('') FOR [p_name]
GO
/****** Object:  Default [DF_Tb_need_product_p_serial]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_product] ADD  CONSTRAINT [DF_Tb_need_product_p_serial]  DEFAULT ('') FOR [p_serial]
GO
/****** Object:  Default [DF_Tb_need_product_p_txm_1]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_product] ADD  CONSTRAINT [DF_Tb_need_product_p_txm_1]  DEFAULT ('') FOR [p_txm]
GO
/****** Object:  Default [DF_Tb_need_product_p_spec]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_product] ADD  CONSTRAINT [DF_Tb_need_product_p_spec]  DEFAULT ('') FOR [p_spec]
GO
/****** Object:  Default [DF_Tb_need_product_p_model]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_product] ADD  CONSTRAINT [DF_Tb_need_product_p_model]  DEFAULT ('') FOR [p_model]
GO
/****** Object:  Default [DF_Tb_need_product_p_price]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_product] ADD  CONSTRAINT [DF_Tb_need_product_p_price]  DEFAULT ((0)) FOR [p_price]
GO
/****** Object:  Default [DF_Tb_need_product_p_quantity]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_product] ADD  CONSTRAINT [DF_Tb_need_product_p_quantity]  DEFAULT ((0)) FOR [p_quantity]
GO
/****** Object:  Default [DF_Tb_need_product_p_baseprice]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_product] ADD  CONSTRAINT [DF_Tb_need_product_p_baseprice]  DEFAULT ((0)) FOR [p_baseprice]
GO
/****** Object:  Default [DF_Tb_need_product_p_brand]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_product] ADD  CONSTRAINT [DF_Tb_need_product_p_brand]  DEFAULT ('') FOR [p_brand]
GO
/****** Object:  Default [DF_Tb_need_product_p_unit]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_product] ADD  CONSTRAINT [DF_Tb_need_product_p_unit]  DEFAULT ('') FOR [p_unit]
GO
/****** Object:  Default [DF_Tb_need_product_p_txm]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_need_product] ADD  CONSTRAINT [DF_Tb_need_product_p_txm]  DEFAULT ('') FOR [p_oldtxm]
GO
/****** Object:  Default [DF_Tb_plan_main_sm_type]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_main] ADD  CONSTRAINT [DF_Tb_plan_main_sm_type]  DEFAULT ((0)) FOR [sm_type]
GO
/****** Object:  Default [DF_tb_storage_main_store_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_main] ADD  CONSTRAINT [DF_tb_storage_main_store_id]  DEFAULT ((0)) FOR [store_id]
GO
/****** Object:  Default [DF_tb_storage_main_sm_sn]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_main] ADD  CONSTRAINT [DF_tb_storage_main_sm_sn]  DEFAULT ('') FOR [sm_sn]
GO
/****** Object:  Default [DF_Tb_plan_main_warehouse_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_main] ADD  CONSTRAINT [DF_Tb_plan_main_warehouse_id]  DEFAULT ((1)) FOR [warehouse_id]
GO
/****** Object:  Default [DF_Tb_plan_main_warehouse_id_to]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_main] ADD  CONSTRAINT [DF_Tb_plan_main_warehouse_id_to]  DEFAULT ((0)) FOR [warehouse_id_to]
GO
/****** Object:  Default [DF_Tb_plan_main_sm_supplierid]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_main] ADD  CONSTRAINT [DF_Tb_plan_main_sm_supplierid]  DEFAULT ((0)) FOR [sm_supplierid]
GO
/****** Object:  Default [DF_tb_storage_main_sm_supplier]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_main] ADD  CONSTRAINT [DF_tb_storage_main_sm_supplier]  DEFAULT ('') FOR [sm_supplier]
GO
/****** Object:  Default [DF_tb_storage_main_sm_date]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_main] ADD  CONSTRAINT [DF_tb_storage_main_sm_date]  DEFAULT (getdate()) FOR [sm_date]
GO
/****** Object:  Default [DF_tb_storage_main_sm_operator]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_main] ADD  CONSTRAINT [DF_tb_storage_main_sm_operator]  DEFAULT ('') FOR [sm_operator]
GO
/****** Object:  Default [DF_tb_storage_main_add_time]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_main] ADD  CONSTRAINT [DF_tb_storage_main_add_time]  DEFAULT (getdate()) FOR [add_time]
GO
/****** Object:  Default [DF_tb_storage_main_sm_status]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_main] ADD  CONSTRAINT [DF_tb_storage_main_sm_status]  DEFAULT ((0)) FOR [sm_status]
GO
/****** Object:  Default [DF_Tb_plan_main_sm_adminid]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_main] ADD  CONSTRAINT [DF_Tb_plan_main_sm_adminid]  DEFAULT ((0)) FOR [sm_adminid]
GO
/****** Object:  Default [DF_Tb_plan_main_sm_iscloth]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_main] ADD  CONSTRAINT [DF_Tb_plan_main_sm_iscloth]  DEFAULT ((0)) FOR [sm_iscloth]
GO
/****** Object:  Default [DF_Tb_plan_main_sm_tax]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_main] ADD  CONSTRAINT [DF_Tb_plan_main_sm_tax]  DEFAULT ((0)) FOR [sm_tax]
GO
/****** Object:  Default [DF_Tb_plan_main_to_warehouse_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_main] ADD  CONSTRAINT [DF_Tb_plan_main_to_warehouse_id]  DEFAULT ((0)) FOR [relate_warehouse_id]
GO
/****** Object:  Default [DF_Tb_plan_product_pro_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_product] ADD  CONSTRAINT [DF_Tb_plan_product_pro_id]  DEFAULT ((0)) FOR [pro_id]
GO
/****** Object:  Default [DF_tb_storage_product_sm_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_product] ADD  CONSTRAINT [DF_tb_storage_product_sm_id]  DEFAULT ((0)) FOR [sm_id]
GO
/****** Object:  Default [DF_Tb_plan_product_sku_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_product] ADD  CONSTRAINT [DF_Tb_plan_product_sku_id]  DEFAULT ((0)) FOR [sku_id]
GO
/****** Object:  Default [DF_tb_storage_product_p_name]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_product] ADD  CONSTRAINT [DF_tb_storage_product_p_name]  DEFAULT ('') FOR [p_name]
GO
/****** Object:  Default [DF_tb_storage_product_p_serial]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_product] ADD  CONSTRAINT [DF_tb_storage_product_p_serial]  DEFAULT ('') FOR [p_serial]
GO
/****** Object:  Default [DF_Tb_plan_product_p_txm_1]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_product] ADD  CONSTRAINT [DF_Tb_plan_product_p_txm_1]  DEFAULT ('') FOR [p_txm]
GO
/****** Object:  Default [DF_Tb_plan_product_p_spec]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_product] ADD  CONSTRAINT [DF_Tb_plan_product_p_spec]  DEFAULT ('') FOR [p_spec]
GO
/****** Object:  Default [DF_Tb_plan_product_p_model]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_product] ADD  CONSTRAINT [DF_Tb_plan_product_p_model]  DEFAULT ('') FOR [p_model]
GO
/****** Object:  Default [DF_tb_storage_product_p_price]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_product] ADD  CONSTRAINT [DF_tb_storage_product_p_price]  DEFAULT ((0)) FOR [p_price]
GO
/****** Object:  Default [DF_tb_storage_product_p_quantity]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_product] ADD  CONSTRAINT [DF_tb_storage_product_p_quantity]  DEFAULT ((0)) FOR [p_quantity]
GO
/****** Object:  Default [DF_tb_storage_product_p_baseprice]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_product] ADD  CONSTRAINT [DF_tb_storage_product_p_baseprice]  DEFAULT ((0)) FOR [p_baseprice]
GO
/****** Object:  Default [DF_Tb_plan_product_p_baseprice_tax]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_product] ADD  CONSTRAINT [DF_Tb_plan_product_p_baseprice_tax]  DEFAULT ((0)) FOR [p_baseprice_tax]
GO
/****** Object:  Default [DF_Tb_plan_product_p_brand]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_product] ADD  CONSTRAINT [DF_Tb_plan_product_p_brand]  DEFAULT ('') FOR [p_brand]
GO
/****** Object:  Default [DF_Tb_plan_product_p_unit]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_product] ADD  CONSTRAINT [DF_Tb_plan_product_p_unit]  DEFAULT ('') FOR [p_unit]
GO
/****** Object:  Default [DF_Tb_plan_product_p_txm]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_plan_product] ADD  CONSTRAINT [DF_Tb_plan_product_p_txm]  DEFAULT ('') FOR [p_oldtxm]
GO
/****** Object:  Default [DF_Tb_storage_main_sm_type]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_main] ADD  CONSTRAINT [DF_Tb_storage_main_sm_type]  DEFAULT ((0)) FOR [sm_type]
GO
/****** Object:  Default [DF_ecm_storage_main_store_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_main] ADD  CONSTRAINT [DF_ecm_storage_main_store_id]  DEFAULT ((0)) FOR [store_id]
GO
/****** Object:  Default [DF_ecm_storage_main_sm_sn]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_main] ADD  CONSTRAINT [DF_ecm_storage_main_sm_sn]  DEFAULT ('') FOR [sm_sn]
GO
/****** Object:  Default [DF_Tb_storage_main_sm_box]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_main] ADD  CONSTRAINT [DF_Tb_storage_main_sm_box]  DEFAULT ('') FOR [sm_box]
GO
/****** Object:  Default [DF_Tb_storage_main_warehouse_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_main] ADD  CONSTRAINT [DF_Tb_storage_main_warehouse_id]  DEFAULT ((1)) FOR [warehouse_id]
GO
/****** Object:  Default [DF_Tb_storage_main_warehouse_id_to]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_main] ADD  CONSTRAINT [DF_Tb_storage_main_warehouse_id_to]  DEFAULT ((0)) FOR [warehouse_id_to]
GO
/****** Object:  Default [DF_Tb_storage_main_warehouse_id_from]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_main] ADD  CONSTRAINT [DF_Tb_storage_main_warehouse_id_from]  DEFAULT ((0)) FOR [warehouse_id_from]
GO
/****** Object:  Default [DF_Tb_storage_main_sm_supplierid]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_main] ADD  CONSTRAINT [DF_Tb_storage_main_sm_supplierid]  DEFAULT ((0)) FOR [sm_supplierid]
GO
/****** Object:  Default [DF_ecm_storage_main_sm_supplier]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_main] ADD  CONSTRAINT [DF_ecm_storage_main_sm_supplier]  DEFAULT ('') FOR [sm_supplier]
GO
/****** Object:  Default [DF_ecm_storage_main_sm_date]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_main] ADD  CONSTRAINT [DF_ecm_storage_main_sm_date]  DEFAULT (getdate()) FOR [sm_date]
GO
/****** Object:  Default [DF_ecm_storage_main_sm_operator]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_main] ADD  CONSTRAINT [DF_ecm_storage_main_sm_operator]  DEFAULT ('') FOR [sm_operator]
GO
/****** Object:  Default [DF_Tb_storage_main_consumer_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_main] ADD  CONSTRAINT [DF_Tb_storage_main_consumer_id]  DEFAULT ((0)) FOR [consumer_id]
GO
/****** Object:  Default [DF_Tb_storage_main_consumer_name]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_main] ADD  CONSTRAINT [DF_Tb_storage_main_consumer_name]  DEFAULT ('') FOR [consumer_name]
GO
/****** Object:  Default [DF_ecm_storage_main_add_time]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_main] ADD  CONSTRAINT [DF_ecm_storage_main_add_time]  DEFAULT (getdate()) FOR [add_time]
GO
/****** Object:  Default [DF_ecm_storage_main_sm_status]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_main] ADD  CONSTRAINT [DF_ecm_storage_main_sm_status]  DEFAULT ((0)) FOR [sm_status]
GO
/****** Object:  Default [DF_Tb_storage_main_sm_adminid]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_main] ADD  CONSTRAINT [DF_Tb_storage_main_sm_adminid]  DEFAULT ((0)) FOR [sm_adminid]
GO
/****** Object:  Default [DF_Tb_storage_main_sm_iscloth]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_main] ADD  CONSTRAINT [DF_Tb_storage_main_sm_iscloth]  DEFAULT ((0)) FOR [sm_iscloth]
GO
/****** Object:  Default [DF_Tb_storage_main_sm_direction]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_main] ADD  CONSTRAINT [DF_Tb_storage_main_sm_direction]  DEFAULT (N'入库') FOR [sm_direction]
GO
/****** Object:  Default [DF_Tb_storage_main_is_direct]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_main] ADD  CONSTRAINT [DF_Tb_storage_main_is_direct]  DEFAULT ((0)) FOR [is_direct]
GO
/****** Object:  Default [DF_Tb_storage_main_relate_sn]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_main] ADD  CONSTRAINT [DF_Tb_storage_main_relate_sn]  DEFAULT ('') FOR [relate_sn]
GO
/****** Object:  Default [DF_Tb_storage_main_sm_verify_adminid]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_main] ADD  CONSTRAINT [DF_Tb_storage_main_sm_verify_adminid]  DEFAULT ((0)) FOR [sm_verify_adminid]
GO
/****** Object:  Default [DF_Tb_storage_product_pro_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_product] ADD  CONSTRAINT [DF_Tb_storage_product_pro_id]  DEFAULT ((0)) FOR [pro_id]
GO
/****** Object:  Default [DF_ecm_storage_product_sm_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_product] ADD  CONSTRAINT [DF_ecm_storage_product_sm_id]  DEFAULT ((0)) FOR [sm_id]
GO
/****** Object:  Default [DF_Tb_storage_product_sku_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_product] ADD  CONSTRAINT [DF_Tb_storage_product_sku_id]  DEFAULT ((0)) FOR [sku_id]
GO
/****** Object:  Default [DF_ecm_storage_product_p_name]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_product] ADD  CONSTRAINT [DF_ecm_storage_product_p_name]  DEFAULT ('') FOR [p_name]
GO
/****** Object:  Default [DF_ecm_storage_product_p_serial]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_product] ADD  CONSTRAINT [DF_ecm_storage_product_p_serial]  DEFAULT ('') FOR [p_serial]
GO
/****** Object:  Default [DF_Tb_storage_product_p_txm_1]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_product] ADD  CONSTRAINT [DF_Tb_storage_product_p_txm_1]  DEFAULT ('') FOR [p_txm]
GO
/****** Object:  Default [DF_Tb_storage_product_p_spec]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_product] ADD  CONSTRAINT [DF_Tb_storage_product_p_spec]  DEFAULT ('') FOR [p_spec]
GO
/****** Object:  Default [DF_Tb_storage_product_p_model]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_product] ADD  CONSTRAINT [DF_Tb_storage_product_p_model]  DEFAULT ('') FOR [p_model]
GO
/****** Object:  Default [DF_ecm_storage_product_p_price]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_product] ADD  CONSTRAINT [DF_ecm_storage_product_p_price]  DEFAULT ((0)) FOR [p_price]
GO
/****** Object:  Default [DF_ecm_storage_product_p_quantity]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_product] ADD  CONSTRAINT [DF_ecm_storage_product_p_quantity]  DEFAULT ((0)) FOR [p_quantity]
GO
/****** Object:  Default [DF_ecm_storage_product_p_baseprice]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_product] ADD  CONSTRAINT [DF_ecm_storage_product_p_baseprice]  DEFAULT ((0)) FOR [p_baseprice]
GO
/****** Object:  Default [DF_Tb_storage_product_p_brand]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_product] ADD  CONSTRAINT [DF_Tb_storage_product_p_brand]  DEFAULT ('') FOR [p_brand]
GO
/****** Object:  Default [DF_Tb_storage_product_p_unit]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_product] ADD  CONSTRAINT [DF_Tb_storage_product_p_unit]  DEFAULT ('') FOR [p_unit]
GO
/****** Object:  Default [DF_Tb_storage_product_p_txm]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_product] ADD  CONSTRAINT [DF_Tb_storage_product_p_txm]  DEFAULT ('') FOR [p_oldtxm]
GO
/****** Object:  Default [DF_Tb_storage_product_p_box]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_storage_product] ADD  CONSTRAINT [DF_Tb_storage_product_p_box]  DEFAULT ('') FOR [p_box]
GO
/****** Object:  Default [DF_Tb_template_pro_name]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_template] ADD  CONSTRAINT [DF_Tb_template_pro_name]  DEFAULT ('') FOR [pro_name]
GO
/****** Object:  Default [DF_Tb_template_pro_code]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_template] ADD  CONSTRAINT [DF_Tb_template_pro_code]  DEFAULT ('') FOR [pro_code]
GO
/****** Object:  Default [DF_Tb_template_factory_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_template] ADD  CONSTRAINT [DF_Tb_template_factory_id]  DEFAULT ((0)) FOR [factory_id]
GO
/****** Object:  Default [DF_Tb_template_do_cost]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_template] ADD  CONSTRAINT [DF_Tb_template_do_cost]  DEFAULT ((0)) FOR [do_cost]
GO
/****** Object:  Default [DF_Tb_template_other_cost]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_template] ADD  CONSTRAINT [DF_Tb_template_other_cost]  DEFAULT ((0)) FOR [other_cost]
GO
/****** Object:  Default [DF_Tb_template_add_time]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_template] ADD  CONSTRAINT [DF_Tb_template_add_time]  DEFAULT (getdate()) FOR [add_time]
GO
/****** Object:  Default [DF_Tb_template_operator]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_template] ADD  CONSTRAINT [DF_Tb_template_operator]  DEFAULT ((0)) FOR [operator]
GO
/****** Object:  Default [DF_Tb_template_tpl_status]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_template] ADD  CONSTRAINT [DF_Tb_template_tpl_status]  DEFAULT ((0)) FOR [tpl_status]
GO
/****** Object:  Default [DF_Tb_template_material_tpl_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_template_material] ADD  CONSTRAINT [DF_Tb_template_material_tpl_id]  DEFAULT ((0)) FOR [tpl_id]
GO
/****** Object:  Default [DF_Tb_template_material_pro_txm_from]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_template_material] ADD  CONSTRAINT [DF_Tb_template_material_pro_txm_from]  DEFAULT ('') FOR [pro_txm_from]
GO
/****** Object:  Default [DF_Tb_template_material_pro_id_from]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_template_material] ADD  CONSTRAINT [DF_Tb_template_material_pro_id_from]  DEFAULT ((0)) FOR [pro_id_from]
GO
/****** Object:  Default [DF_Tb_template_material_pro_nums]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_template_material] ADD  CONSTRAINT [DF_Tb_template_material_pro_nums]  DEFAULT ((0)) FOR [pro_nums]
GO
/****** Object:  Default [DF_Tb_template_material_add_time]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_template_material] ADD  CONSTRAINT [DF_Tb_template_material_add_time]  DEFAULT (getdate()) FOR [add_time]
GO
/****** Object:  Default [DF_Tb_User_User_name]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_User] ADD  CONSTRAINT [DF_Tb_User_User_name]  DEFAULT ('') FOR [User_name]
GO
/****** Object:  Default [DF_Tb_User_True_name]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_User] ADD  CONSTRAINT [DF_Tb_User_True_name]  DEFAULT ('') FOR [True_name]
GO
/****** Object:  Default [DF_Tb_User_Add_time]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_User] ADD  CONSTRAINT [DF_Tb_User_Add_time]  DEFAULT (getdate()) FOR [Add_time]
GO
/****** Object:  Default [DF_Tb_User_Password]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_User] ADD  CONSTRAINT [DF_Tb_User_Password]  DEFAULT ('') FOR [User_Pwd]
GO
/****** Object:  Default [DF_Tb_User_User_level]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_User] ADD  CONSTRAINT [DF_Tb_User_User_level]  DEFAULT ((0)) FOR [User_level]
GO
/****** Object:  Default [DF_Tb_User_User_Mobile]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_User] ADD  CONSTRAINT [DF_Tb_User_User_Mobile]  DEFAULT ('') FOR [User_Mobile]
GO
/****** Object:  Default [DF_Tb_User_cashier_id_from]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_User] ADD  CONSTRAINT [DF_Tb_User_cashier_id_from]  DEFAULT ((0)) FOR [cashier_id_from]
GO
/****** Object:  Default [DF_Tb_User_store_id_from]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_User] ADD  CONSTRAINT [DF_Tb_User_store_id_from]  DEFAULT ((0)) FOR [store_id_from]
GO
/****** Object:  Default [DF_Tb_User_Account_money]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_User] ADD  CONSTRAINT [DF_Tb_User_Account_money]  DEFAULT ((0)) FOR [Account_money]
GO
/****** Object:  Default [DF_Tb_User_Account_score]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_User] ADD  CONSTRAINT [DF_Tb_User_Account_score]  DEFAULT ((0)) FOR [Account_score]
GO
/****** Object:  Default [DF_Tb_User_is_hide]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_User] ADD  CONSTRAINT [DF_Tb_User_is_hide]  DEFAULT ((0)) FOR [is_hide]
GO
/****** Object:  Default [DF_Tb_Working_work_sn]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_Working] ADD  CONSTRAINT [DF_Tb_Working_work_sn]  DEFAULT ('') FOR [work_sn]
GO
/****** Object:  Default [DF_Tb_Working_factory_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_Working] ADD  CONSTRAINT [DF_Tb_Working_factory_id]  DEFAULT ((0)) FOR [factory_id]
GO
/****** Object:  Default [DF_Tb_Working_warehouse_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_Working] ADD  CONSTRAINT [DF_Tb_Working_warehouse_id]  DEFAULT ((0)) FOR [warehouse_id]
GO
/****** Object:  Default [DF_Tb_Working_add_time]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_Working] ADD  CONSTRAINT [DF_Tb_Working_add_time]  DEFAULT (getdate()) FOR [add_time]
GO
/****** Object:  Default [DF_Tb_Working_work_status]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_Working] ADD  CONSTRAINT [DF_Tb_Working_work_status]  DEFAULT ((0)) FOR [work_status]
GO
/****** Object:  Default [DF_Tb_Working_our_manager]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_Working] ADD  CONSTRAINT [DF_Tb_Working_our_manager]  DEFAULT ('') FOR [our_manager]
GO
/****** Object:  Default [DF_Tb_Working_factory_manager]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_Working] ADD  CONSTRAINT [DF_Tb_Working_factory_manager]  DEFAULT ('') FOR [factory_manager]
GO
/****** Object:  Default [DF_Tb_Working_operator_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_Working] ADD  CONSTRAINT [DF_Tb_Working_operator_id]  DEFAULT ((0)) FOR [operator_id]
GO
/****** Object:  Default [DF_Tb_working_cart_tpl_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_working_cart_del] ADD  CONSTRAINT [DF_Tb_working_cart_tpl_id]  DEFAULT ((0)) FOR [tpl_id]
GO
/****** Object:  Default [DF_Tb_working_cart_pro_nums]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_working_cart_del] ADD  CONSTRAINT [DF_Tb_working_cart_pro_nums]  DEFAULT ((0)) FOR [quantity]
GO
/****** Object:  Default [DF_Tb_working_cart_operator_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_working_cart_del] ADD  CONSTRAINT [DF_Tb_working_cart_operator_id]  DEFAULT ((0)) FOR [operator_id]
GO
/****** Object:  Default [DF_Tb_working_cart_add_time]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_working_cart_del] ADD  CONSTRAINT [DF_Tb_working_cart_add_time]  DEFAULT (getdate()) FOR [add_time]
GO
/****** Object:  Default [DF_Tb_Working_main_work_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_Working_main] ADD  CONSTRAINT [DF_Tb_Working_main_work_id]  DEFAULT ((0)) FOR [work_id]
GO
/****** Object:  Default [DF_Tb_Working_main_tpl_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_Working_main] ADD  CONSTRAINT [DF_Tb_Working_main_tpl_id]  DEFAULT ((0)) FOR [tpl_id]
GO
/****** Object:  Default [DF_Tb_Working_main_pro_code]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_Working_main] ADD  CONSTRAINT [DF_Tb_Working_main_pro_code]  DEFAULT ('') FOR [pro_code_new]
GO
/****** Object:  Default [DF_Tb_Working_main_pro_nums]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_Working_main] ADD  CONSTRAINT [DF_Tb_Working_main_pro_nums]  DEFAULT ((0)) FOR [quantity]
GO
/****** Object:  Default [DF_Tb_Working_main_do_cost]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_Working_main] ADD  CONSTRAINT [DF_Tb_Working_main_do_cost]  DEFAULT ((0)) FOR [do_cost]
GO
/****** Object:  Default [DF_Tb_Working_main_other_cost]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_Working_main] ADD  CONSTRAINT [DF_Tb_Working_main_other_cost]  DEFAULT ((0)) FOR [other_cost]
GO
/****** Object:  Default [DF_Tb_Working_main_material_cost]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_Working_main] ADD  CONSTRAINT [DF_Tb_Working_main_material_cost]  DEFAULT ((0)) FOR [material_cost]
GO
/****** Object:  Default [DF_Tb_Working_main_operator_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_Working_main] ADD  CONSTRAINT [DF_Tb_Working_main_operator_id]  DEFAULT ((0)) FOR [operator_id]
GO
/****** Object:  Default [DF_Tb_Working_material_wm_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_Working_material] ADD  CONSTRAINT [DF_Tb_Working_material_wm_id]  DEFAULT ((0)) FOR [wm_id]
GO
/****** Object:  Default [DF_Tb_Working_material_work_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_Working_material] ADD  CONSTRAINT [DF_Tb_Working_material_work_id]  DEFAULT ((0)) FOR [work_id]
GO
/****** Object:  Default [DF_Tb_Working_material_pro_real_nums]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[Tb_Working_material] ADD  CONSTRAINT [DF_Tb_Working_material_pro_real_nums]  DEFAULT ((0)) FOR [pro_real_nums]
GO
/****** Object:  Default [DF_UserMoneyAction_MoneyAmount]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[UserMoneyAction] ADD  CONSTRAINT [DF_UserMoneyAction_MoneyAmount]  DEFAULT ((0)) FOR [MoneyAmount]
GO
/****** Object:  Default [DF_UserMoneyAction_DoFlag]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[UserMoneyAction] ADD  CONSTRAINT [DF_UserMoneyAction_DoFlag]  DEFAULT ((0)) FOR [DoFlag]
GO
/****** Object:  Default [DF_UserMoneyAction_AddTime]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[UserMoneyAction] ADD  CONSTRAINT [DF_UserMoneyAction_AddTime]  DEFAULT (getdate()) FOR [AddTime]
GO
/****** Object:  Default [DF_wareHouse_Admin_warehouse_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[wareHouse_Admin] ADD  CONSTRAINT [DF_wareHouse_Admin_warehouse_id]  DEFAULT ((0)) FOR [warehouse_id]
GO
/****** Object:  Default [DF_wareHouse_Admin_LoginName]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[wareHouse_Admin] ADD  CONSTRAINT [DF_wareHouse_Admin_LoginName]  DEFAULT ('') FOR [LoginName]
GO
/****** Object:  Default [DF_wareHouse_Admin_add_date]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[wareHouse_Admin] ADD  CONSTRAINT [DF_wareHouse_Admin_add_date]  DEFAULT (getdate()) FOR [add_date]
GO
/****** Object:  Default [DF_wareHouse_Admin_IsLock]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[wareHouse_Admin] ADD  CONSTRAINT [DF_wareHouse_Admin_IsLock]  DEFAULT ((0)) FOR [IsLock]
GO
/****** Object:  Default [DF_wareHouse_Admin_RoleID]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[wareHouse_Admin] ADD  CONSTRAINT [DF_wareHouse_Admin_RoleID]  DEFAULT ((0)) FOR [RoleID]
GO
/****** Object:  Default [DF_WareHouse_List_add_date]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[WareHouse_List] ADD  CONSTRAINT [DF_WareHouse_List_add_date]  DEFAULT (getdate()) FOR [add_date]
GO
/****** Object:  Default [DF_WareHouse_List_islock]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[WareHouse_List] ADD  CONSTRAINT [DF_WareHouse_List_islock]  DEFAULT ((0)) FOR [IsLock]
GO
/****** Object:  Default [DF_WareHouse_List_StoreId]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[WareHouse_List] ADD  CONSTRAINT [DF_WareHouse_List_StoreId]  DEFAULT ((0)) FOR [StoreId]
GO
/****** Object:  Default [DF_WareHouse_List_is_caigou]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[WareHouse_List] ADD  CONSTRAINT [DF_WareHouse_List_is_caigou]  DEFAULT ((0)) FOR [is_caigou]
GO
/****** Object:  Default [DF_WareHouse_List_is_manage]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[WareHouse_List] ADD  CONSTRAINT [DF_WareHouse_List_is_manage]  DEFAULT ((0)) FOR [is_manage]
GO
/****** Object:  Default [DF_WareHouse_List_agent_id]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[WareHouse_List] ADD  CONSTRAINT [DF_WareHouse_List_agent_id]  DEFAULT ((0)) FOR [agent_id]
GO
/****** Object:  Default [DF_wuliu_gongshi_add_date]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[wuliu_gongshi] ADD  CONSTRAINT [DF_wuliu_gongshi_add_date]  DEFAULT (getdate()) FOR [add_date]
GO
/****** Object:  Default [DF__wuliu_gon__is_Di__6E96540A]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[wuliu_gongshi] ADD  DEFAULT ((0)) FOR [is_Display]
GO
/****** Object:  Default [DF__wuliu_gon__Servi__6F8A7843]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[wuliu_gongshi] ADD  DEFAULT ((0)) FOR [ServiceRate]
GO
/****** Object:  Default [DF__wuliu_gon__IsExp__707E9C7C]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[wuliu_gongshi] ADD  DEFAULT ((0)) FOR [IsExpress]
GO
/****** Object:  Default [DF_wuliu_gongshi_shfs]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[wuliu_gongshi] ADD  CONSTRAINT [DF_wuliu_gongshi_shfs]  DEFAULT ((0)) FOR [shfs]
GO
/****** Object:  Default [DF__wuliu_gon__updat__7266E4EE]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[wuliu_gongshi] ADD  DEFAULT (getdate()) FOR [updateTime]
GO
/****** Object:  Default [DF__wuliu_gon__isLoc__735B0927]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[wuliu_gongshi] ADD  DEFAULT ((0)) FOR [isLocal]
GO
/****** Object:  ForeignKey [FK_WareHouse_List_WareHouse_List]    Script Date: 12/04/2017 15:04:58 ******/
ALTER TABLE [dbo].[WareHouse_List]  WITH CHECK ADD  CONSTRAINT [FK_WareHouse_List_WareHouse_List] FOREIGN KEY([warehouse_id])
REFERENCES [dbo].[WareHouse_List] ([warehouse_id])
GO
ALTER TABLE [dbo].[WareHouse_List] CHECK CONSTRAINT [FK_WareHouse_List_WareHouse_List]
GO
