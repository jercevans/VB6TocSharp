Attribute VB_Name = "modConfig"
Option Explicit

Public Const SpIndent As Long = 2
Public Const DefaultDataType As String = "dynamic"

Public Const PackagePrefix As String = ""
Private Const def_vbpFile As String = "C:\wincds\wincds\wincds.vbp"
Private Const def_outputFolder As String = "C:\WinCDS.NET\out\WinCDS.NET\"
Private Const def_AssemblyName As String = "WinCDS"

Private mVBPFile As String
Private mOutputFolder As String
Private mAssemblyName As String

Public Const INISection_Settings   As String = "Settings"
Public Const INIKey_VBPFile As String = "VBPFile"
Public Const INIKey_OutputFolder As String = "OutputFolder"
Public Const INIKey_AssemblyName As String = "AssemblyName"

Public Function INIFile() As String
  INIFile = App.Path & "\VB6toCS.INI"
End Function

Public Sub LoadSettings()
  mVBPFile = modINI.INIRead(INISection_Settings, INIKey_VBPFile, INIFile)
  mOutputFolder = modINI.INIRead(INISection_Settings, INIKey_OutputFolder, INIFile)
  mAssemblyName = modINI.INIRead(INISection_Settings, INIKey_AssemblyName, INIFile)
End Sub

Public Function OutputFolder(Optional ByVal F As String) As String
  If mOutputFolder = "" Then mOutputFolder = def_outputFolder
  OutputFolder = mOutputFolder & OutputSubFolder(F)
End Function

Public Function AssemblyName() As String
  If mAssemblyName = "" Then mAssemblyName = def_AssemblyName
  AssemblyName = mAssemblyName
End Function

Public Function OutputSubFolder(ByVal F As String) As String
  Select Case FileExt(F)
    Case ".bas": OutputSubFolder = "Modules\"
    Case ".cls": OutputSubFolder = "Classes\"
    Case ".frm": OutputSubFolder = "Forms\"
    Case Else:   OutputSubFolder = ""
  End Select
End Function

Public Property Get vbpFile() As String
  If mVBPFile = "" Then mVBPFile = def_vbpFile
  vbpFile = mVBPFile
End Property

Public Property Get vbpPath() As String
  vbpPath = FilePath(vbpFile)
End Property


