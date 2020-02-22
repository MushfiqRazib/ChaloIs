<!-- #include file="./functions.asp" -->
<!-- #include file="htmlform.asp" -->
<%
Dim rs, sql, oForm, oFile, version,Dir
Dim ArtikelNr, itemDescr, fileName, errMsg
'*** Get page values
 ArtikelNr = Request("artikelnr")
 version   = Request("version")
 docPath   = Request("docPath")
     
'*** Use HTMLForm component because we need binary data for file upload.
Set oForm = New HTMLForm

If oForm.Submitted Then
  '*** Get file.
  Set oFile = oForm("FileName")    
  itemDescr = oForm("FileDisplay")   
  ArtikelNr = oForm("artikelnr")
  version   = oForm("version")   
  docPath   = oForm("docPath")
  
  
  If (oFile.FileSize > 0) Then
    'itemDescr = getFormatedText(itemDescr)
    IF version="" Then
     fileName = ArtikelNr & "_" & oFile.FileName & "." & oFile.FileExt
    Else
    
    fileName = ArtikelNr & "_" & version & "_" & oFile.FileName & "." & oFile.FileExt
    
    End If
    docPath  = docPath & "\" & fileName
    If(NOT FileExists(docPath)) Then    
       oFile.SaveAs(docPath)     
       IF version="" Then
            Response.Write("<script>self.close();window.opener.Reload();window.opener.focus();</script>")
       Else
            Response.Write("<script>self.close();window.opener.Reload('"+version+"');window.opener.focus();</script>")
       End If
       Response.End()         
    End If     
  End If
End If

Function getFormatedText(text)
       Dim i
       Dim myText
       Dim returnText
       myText = Split(text," ")
       
       For i = 0 to UBound(myText) 
         If Trim(myText(i)) <> "" Then
          returnText = returnText & Trim(myText(i)) & "_"
         End If 
       Next
       returnText = Left(returnText,Len(returnText)-1)
       getFormatedText = returnText
End Function


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head id="Head1" runat="server">
    <title>ADD Bijlage</title>
    <link href="styles/datagrid.css" type="text/css" rel="stylesheet" />

    <script type="text/javascript" src="./script/AddAttachment.js"></script>

    <script type="text/javascript" src="./script/common.js"></script>

    <script type="text/javascript" src="./script/sarissa.js"></script>

    <script type="text/javascript" src="./script/window.js"></script>

</head>
<body class="BodyStyle">
    <form name="ItemForm" action="./AddTaskAttachment.asp" enctype="multipart/form-data"
    method="POST">
    <div style="position: absolute; left: 30px; top: 30px; width: 416px; height: 211px;">
        <table>
            <tr>
                <td style="width: 403px">
                    <table border="0" style="width: 390px">
                        <tr>
                            <td colspan="2" style="padding-bottom: 30px; text-align: left">
                                <% If version<>"X" Then %>
                                Bijlage voor Artikel: <b>
                                    <%=ArtikelNr %></b> Revisie: <b>
                                        <%=version %></b>
                                <% Else %>
                                Algemene Bijlage
                                <% End If %>
                            </td>
                        </tr>
                        <!--<tr>
                            <td style="width: 102px; height: 24px; padding-bottom: 10px;">
                                Omschrijving :
                            </td>
                            <td style="height: 24px; width: 272px; padding-bottom: 10px;">
                                <input type="text" id="omschrijsving" name="omschrijving" maxlength="15" style="width: 146px"
                                    onkeypress='return CheckValues(event)' />
                            </td>
                        </tr>
                        <div id="myDiv" style="position: absolute; border-style: solid; border-width: thin;
                            border-color: Black; position: absolute; left: 117px; top: 526px; width: 356px;
                            visibility: hidden; height: 22px; background-color: #ffffcc;">
                            <span id="myspan" style="background-color: #ffffcc; width: 100%; height: 21px;">&nbsp;
                                \ / : * ? " < > | &nbsp; these characters are not allowed...</span>
                        </div>-->
                        <tr>
                            <td style="width: 102px; padding-bottom: 10px;">
                                Bestand &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
                            </td>
                            <td style="width: 272px">
                                <div class="FileBrowse">
                                    <input type="file" class="FileBrowse" name="fileName" value="" onchange="setElementAttrib('FileDisplay', 'value', this.value)">
                                </div>
                                <input type="text" class="FileDisplay" id="FileDisplay" value="" style="width: 145px" />
                                <input type="button" class="FileButton" value="Browse..." onfocus="this.blur()" style="left: -6px;
                                    width: 61px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="width: 300px; padding-top: 40px;">
                                <input type="button" id="add" style="width: 90px; height: 24px;" onclick="itemSubmit()" value="Toevoegen" />
                                    
                                &nbsp;
                                <input type="button" id="btnCancel" style="width: 90px; height: 24px;" onclick="window.close()" value="Cancel" />
                                    
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    
    <input type="hidden" name="artikelnr" value='<%= ArtikelNr%>' />
    <input type="hidden" name="version" value='<%= version%>' />
    <input type="hidden" name="docPath" value='<%=docPath %>' />
    </form>
</body>
</html>
