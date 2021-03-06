VERSION 5.00
Begin VB.Form frm 
   Caption         =   "VB6 -> .NET"
   ClientHeight    =   4380
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   5190
   LinkTopic       =   "Form1"
   ScaleHeight     =   4380
   ScaleWidth      =   5190
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame fra 
      Height          =   4095
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   4935
      Begin VB.CommandButton cmdLint 
         Caption         =   "L&int"
         Height          =   285
         Left            =   3960
         TabIndex        =   11
         Top             =   600
         Width           =   855
      End
      Begin VB.CommandButton cmdConfig 
         Caption         =   "Conf&ig"
         Height          =   285
         Left            =   3960
         TabIndex        =   10
         Top             =   240
         Width           =   855
      End
      Begin VB.TextBox txtStats 
         Appearance      =   0  'Flat
         BackColor       =   &H8000000F&
         Height          =   1695
         Left            =   2040
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   8
         Top             =   1320
         Width           =   2655
      End
      Begin VB.CommandButton cmdClasses 
         Caption         =   "Classes"
         Height          =   495
         Left            =   240
         TabIndex        =   7
         Top             =   1920
         Width           =   1455
      End
      Begin VB.CommandButton cmdModules 
         Caption         =   "Modules"
         Height          =   495
         Left            =   240
         TabIndex        =   6
         Top             =   2520
         Width           =   1455
      End
      Begin VB.CommandButton cmdAll 
         Caption         =   "ALL"
         Height          =   495
         Left            =   240
         TabIndex        =   5
         Top             =   3480
         Width           =   1455
      End
      Begin VB.CommandButton cmdForms 
         Caption         =   "Forms"
         Height          =   495
         Left            =   240
         TabIndex        =   4
         Top             =   1320
         Width           =   1455
      End
      Begin VB.CommandButton cmdExit 
         Cancel          =   -1  'True
         Caption         =   "E&xit"
         Height          =   495
         Left            =   3240
         TabIndex        =   3
         Top             =   3480
         Width           =   1455
      End
      Begin VB.TextBox txtSrc 
         Height          =   285
         Left            =   1200
         Locked          =   -1  'True
         TabIndex        =   1
         Text            =   "C:\WinCDS\WinCDS\WinCDS.vbp"
         Top             =   240
         Width           =   2655
      End
      Begin VB.Label lblPrg 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Height          =   255
         Left            =   2040
         TabIndex        =   9
         Top             =   3120
         Width           =   2415
      End
      Begin VB.Shape shpPrgBack 
         BackColor       =   &H00FFC0C0&
         Height          =   255
         Left            =   2040
         Top             =   3120
         Width           =   2415
      End
      Begin VB.Shape shpPrg 
         BackColor       =   &H00FFC0C0&
         BackStyle       =   1  'Opaque
         BorderStyle     =   0  'Transparent
         Height          =   255
         Left            =   2040
         Top             =   3120
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.Label lblSrc 
         Alignment       =   1  'Right Justify
         Caption         =   "Project File:"
         Height          =   255
         Left            =   240
         TabIndex        =   2
         Top             =   240
         Width           =   855
      End
   End
End
Attribute VB_Name = "frm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public pMax As Long

Private Sub cmdAll_Click()
  IsWorking
  ConvertProject txtSrc
  IsWorking True
End Sub

Private Sub cmdClasses_Click()
  IsWorking
  ConvertFileList FilePath(txtSrc), VBPClasses(txtSrc)
  IsWorking True
End Sub

Private Sub cmdConfig_Click()
  frmConfig.Show 1
End Sub

Private Sub cmdExit_Click()
  Unload Me
End Sub

Private Sub cmdForms_Click()
  IsWorking
  ConvertFileList FilePath(txtSrc), VBPForms(txtSrc)
  IsWorking True
End Sub

Private Sub cmdModules_Click()
  IsWorking
  ConvertFileList FilePath(txtSrc), VBPModules(txtSrc)
  IsWorking True
End Sub

Private Sub IsWorking(Optional ByVal Done As Boolean)
  cmdAll.Enabled = Done
  cmdClasses.Enabled = Done
  cmdExit.Enabled = Done
  cmdForms.Enabled = Done
  cmdModules.Enabled = Done
  txtSrc.Enabled = Done
End Sub

Public Function Prg(Optional ByVal Val As Long = -1, Optional ByVal Max As Long = -1, Optional ByVal Cap As String = "#")
On Error Resume Next
  If Max >= 0 Then pMax = Max
  lblPrg = IIf(Prg = "#", "", Cap)
  shpPrg.Width = Val / pMax * 2415
  shpPrg.Visible = Val >= 0
  lblPrg.Visible = shpPrg.Visible
End Function

Private Sub cmdLint_Click()
  LintFolder
End Sub

Private Sub Form_Load()
  modConfig.LoadSettings
  txtSrc = vbpFile
End Sub
