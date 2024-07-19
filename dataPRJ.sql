USE [DocumentManagementSystem]
GO
/****** Object:  Table [dbo].[Documents]    Script Date: 7/19/2024 8:38:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Documents](
	[DocumentID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](100) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[FilePath] [nvarchar](max) NOT NULL,
	[UploadedBy] [int] NULL,
	[UploadDate] [datetime] NULL,
	[DocumentTypeID] [int] NULL,
 CONSTRAINT [PK__Document__1ABEEF6F1E5E271D] PRIMARY KEY CLUSTERED 
(
	[DocumentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DocumentTypes]    Script Date: 7/19/2024 8:38:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocumentTypes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
 CONSTRAINT [PK_DocumentTypes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Note]    Script Date: 7/19/2024 8:38:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Note](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](max) NULL,
	[note] [nvarchar](max) NULL,
	[userId] [int] NOT NULL,
	[createDate] [datetime] NULL,
	[modifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Note] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 7/19/2024 8:38:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 7/19/2024 8:38:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](255) NOT NULL,
	[Email] [varchar](100) NULL,
	[RoleID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Documents] ON 

INSERT [dbo].[Documents] ([DocumentID], [Title], [Description], [FilePath], [UploadedBy], [UploadDate], [DocumentTypeID]) VALUES (1, N'Project Plan', N'Project planning document', N'/documents/Workshop_01_AutomobileManagement.pdf', 2, CAST(N'2024-07-01T09:30:00.000' AS DateTime), 1)
INSERT [dbo].[Documents] ([DocumentID], [Title], [Description], [FilePath], [UploadedBy], [UploadDate], [DocumentTypeID]) VALUES (2, N'Meeting Notes', N'Notes from the meeting held on 2024-06-30', N'/WebApplication3/documents/Lab1_Requirements.pdf', 1, CAST(N'2024-07-02T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Documents] ([DocumentID], [Title], [Description], [FilePath], [UploadedBy], [UploadDate], [DocumentTypeID]) VALUES (3, N'Budget Report', N'Annual budget report for the fiscal year 2024', N'/documents/budget_report.pdf', 1, CAST(N'2024-07-03T11:15:00.000' AS DateTime), 1)
INSERT [dbo].[Documents] ([DocumentID], [Title], [Description], [FilePath], [UploadedBy], [UploadDate], [DocumentTypeID]) VALUES (4, N'Technical Specification', N'Technical specification document for the new product', N'/documents/technical_specification.pdf', 1, CAST(N'2024-07-04T08:45:00.000' AS DateTime), 1)
INSERT [dbo].[Documents] ([DocumentID], [Title], [Description], [FilePath], [UploadedBy], [UploadDate], [DocumentTypeID]) VALUES (5, N'User Manual', N'User manual for the new software', N'/documents/user_manual.pdf', 1, CAST(N'2024-07-05T14:20:00.000' AS DateTime), 1)
INSERT [dbo].[Documents] ([DocumentID], [Title], [Description], [FilePath], [UploadedBy], [UploadDate], [DocumentTypeID]) VALUES (6, N'Design Document', N'Design document for the new system architecture', N'/documents/design_document.pdf', 1, CAST(N'2024-07-06T15:30:00.000' AS DateTime), 1)
INSERT [dbo].[Documents] ([DocumentID], [Title], [Description], [FilePath], [UploadedBy], [UploadDate], [DocumentTypeID]) VALUES (7, N'HR Policy', N'Updated HR policies for 2024', N'/documents/hr_policy.pdf', 1, CAST(N'2024-07-07T16:00:00.000' AS DateTime), 1)
INSERT [dbo].[Documents] ([DocumentID], [Title], [Description], [FilePath], [UploadedBy], [UploadDate], [DocumentTypeID]) VALUES (11, N'vcxvxc', N'vxcvxc', N'/WebApplication3/documents/ProductInformation (1) (2).pdf', NULL, CAST(N'2024-07-11T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Documents] ([DocumentID], [Title], [Description], [FilePath], [UploadedBy], [UploadDate], [DocumentTypeID]) VALUES (12, N'vcxvxc', N'vxcvxc', N'/WebApplication3/documents/Hospital HR-700-LOC.pdf', NULL, CAST(N'2024-07-14T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Documents] ([DocumentID], [Title], [Description], [FilePath], [UploadedBy], [UploadDate], [DocumentTypeID]) VALUES (13, N'123', N'vxcvcx', N'/WebApplication3/documents/Workshop_02_MobileShop (1).pdf', NULL, CAST(N'2024-07-14T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Documents] ([DocumentID], [Title], [Description], [FilePath], [UploadedBy], [UploadDate], [DocumentTypeID]) VALUES (14, N'test1', N'no', N'/ProjectPRJ/documents/Workshop_01_AutomobileManagement.pdf', 1, CAST(N'2024-07-17T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Documents] ([DocumentID], [Title], [Description], [FilePath], [UploadedBy], [UploadDate], [DocumentTypeID]) VALUES (15, N'test2', N'no', N'/ProjectPRJ/documents/Quiz_On tap giua ky_JPD113.pdf', 1, CAST(N'2024-07-20T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Documents] ([DocumentID], [Title], [Description], [FilePath], [UploadedBy], [UploadDate], [DocumentTypeID]) VALUES (16, N'test3', N'fadfs', N'/ProjectPRJ/documents/Tổng hợp ngữ pháp JPD113-123.pdf', 1, CAST(N'2024-07-08T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Documents] ([DocumentID], [Title], [Description], [FilePath], [UploadedBy], [UploadDate], [DocumentTypeID]) VALUES (17, N'test4', N'fadfs', N'/ProjectPRJ/documents/on_tap_fa22.pdf', 1, CAST(N'2024-07-13T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Documents] ([DocumentID], [Title], [Description], [FilePath], [UploadedBy], [UploadDate], [DocumentTypeID]) VALUES (18, N'test5', N'no ', N'/ProjectPRJ/documents/Workshop_01_AutomobileManagement.pdf', 1, CAST(N'2024-07-20T00:00:00.000' AS DateTime), 2)
SET IDENTITY_INSERT [dbo].[Documents] OFF
GO
SET IDENTITY_INSERT [dbo].[DocumentTypes] ON 

INSERT [dbo].[DocumentTypes] ([id], [name]) VALUES (1, N'pdf')
INSERT [dbo].[DocumentTypes] ([id], [name]) VALUES (2, N'word')
SET IDENTITY_INSERT [dbo].[DocumentTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Note] ON 

INSERT [dbo].[Note] ([id], [title], [note], [userId], [createDate], [modifiedDate]) VALUES (1, N'tai lieu ', N'cach an uong hieu qua ', 1, CAST(N'2024-07-17T08:52:02.130' AS DateTime), CAST(N'2024-07-17T08:52:02.130' AS DateTime))
INSERT [dbo].[Note] ([id], [title], [note], [userId], [createDate], [modifiedDate]) VALUES (2, N'toan', NULL, 2, CAST(N'2024-07-17T10:49:01.517' AS DateTime), CAST(N'2024-07-18T00:43:29.683' AS DateTime))
INSERT [dbo].[Note] ([id], [title], [note], [userId], [createDate], [modifiedDate]) VALUES (11, N'fsf', N'fdsf', 2, CAST(N'2024-07-18T01:07:36.620' AS DateTime), CAST(N'2024-07-18T01:07:36.620' AS DateTime))
SET IDENTITY_INSERT [dbo].[Note] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (1, N'User')
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (2, N'Admin')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [Username], [Password], [Email], [RoleID]) VALUES (1, N'admin', N'123', N'admin@example.com', 2)
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Email], [RoleID]) VALUES (2, N'user', N'123', N'user@gmail.com', 1)
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Email], [RoleID]) VALUES (3, N'Phatct', N'1234', N'phatnvhe182036@fpt.edu.vn', NULL)
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Email], [RoleID]) VALUES (4, N'Phat', N'123', N'ducpmhe181815@fpt.edu.vn', NULL)
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Email], [RoleID]) VALUES (5, N'user1', N'123', N'phatn@gamfdal.cona', NULL)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__536C85E47AAD7E8B]    Script Date: 7/19/2024 8:38:15 AM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Documents] ADD  CONSTRAINT [DF__Documents__Uploa__2A4B4B5E]  DEFAULT (getdate()) FOR [UploadDate]
GO
ALTER TABLE [dbo].[Note] ADD  CONSTRAINT [DF_Note_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[Note] ADD  CONSTRAINT [DF_Note_modifiedDate]  DEFAULT (getdate()) FOR [modifiedDate]
GO
ALTER TABLE [dbo].[Documents]  WITH CHECK ADD  CONSTRAINT [FK__Documents__Uploa__2B3F6F97] FOREIGN KEY([UploadedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Documents] CHECK CONSTRAINT [FK__Documents__Uploa__2B3F6F97]
GO
ALTER TABLE [dbo].[Documents]  WITH CHECK ADD  CONSTRAINT [FK_Documents_DocumentTypes] FOREIGN KEY([DocumentTypeID])
REFERENCES [dbo].[DocumentTypes] ([id])
GO
ALTER TABLE [dbo].[Documents] CHECK CONSTRAINT [FK_Documents_DocumentTypes]
GO
ALTER TABLE [dbo].[Note]  WITH CHECK ADD  CONSTRAINT [FK_Note_Users] FOREIGN KEY([userId])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Note] CHECK CONSTRAINT [FK_Note_Users]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
