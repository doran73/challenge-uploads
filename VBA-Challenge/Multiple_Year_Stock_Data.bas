Attribute VB_Name = "Module1"

Sub WorksheetLoop():

         Dim WS_Count As Integer
         Dim I As Integer

         ' Set WS_Count equal to the number of worksheets in the active
         ' workbook.
         WS_Count = ActiveWorkbook.Worksheets.Count

         ' Begin the loop.
         For I = 1 To WS_Count

            ' Insert your code here.
            'MsgBox "Processing Sheet: " & I & "OF: " & WS_Count
            Call ProcessSheet(I)
            ' The following line shows how to reference a sheet within
            ' the loop by displaying the worksheet name in a dialog box.
            'MsgBox ActiveWorkbook.Worksheets(I).Name

         Next I
        MsgBox "All Done"
        Worksheets(1).Activate
        
      End Sub


Sub ProcessSheet(SheetNum As Integer):
Worksheets(SheetNum).Activate
'Call CreateHeaderRow
Dim Ticker As String
Dim Ticker2 As String
Dim StartRow As Long
Dim EndRow As Long
Dim OutputCount As Long
Dim LastRow As Long
LastRow = Cells(Rows.Count, 1).End(xlUp).Row

StartRow = 2
OutputCount = 2



    For I = 2 To LastRow
        Ticker = Cells(I, 1).Value
        Ticker2 = Cells(I + 1, 1).Value

            If Ticker <> Ticker2 Then
                EndRow = I
                Call PopulateTicker(Ticker, StartRow, EndRow, OutputCount)
        
                'MsgBox "Ticker 1 Value is:" & Ticker & " Ticker2 Value is:" & Ticker2 & "i is:" & i
                'set variables
                OutputCount = OutputCount + 1
                StartRow = I + 1
                Ticker = Cells(I + 1, 1).Value
      
    
    
    
            End If
    

    Next I
    'populate ticker name,greatest % increase, greatest % decrease, greatest Stock volume
    Call GetGreatest
End Sub

Function PopulateTicker(TickerValue As String, StartRow As Long, EndRow As Long, OutputCount As Long):
'The ticker symbol
'Yearly change from the opening price at the beginning of a given year to the closing price at the end of that year.
'The percentage change from the opening price at the beginning of a given year to the closing price at the end of that year.
'The total stock volume of the stock
Dim sOpen As Double
Dim sClose As Double
Dim rng As Range
Dim RangeString As String
Dim YearChange As Double
Dim PercentChange As Double

    sOpen = Cells(StartRow, 3).Value
    sClose = Cells(EndRow, 6).Value
    YearChange = sClose - sOpen
    PercentChange = (sClose - sOpen) / sOpen
    RangeString = "G" & StartRow & ":" & "G" & EndRow
    Set rng = Range(RangeString)
    'populate ticker information starting at column i (column number 9)
    Cells(OutputCount, 9) = TickerValue
    'populate open price
    Cells(OutputCount, 10) = sOpen
    'populate close price
    Cells(OutputCount, 11) = sClose
    'Total Volume is the sum of the range
    Cells(OutputCount, 12) = WorksheetFunction.Sum(rng)
    'Yearly Change
    Cells(OutputCount, 13) = YearChange
    'Conditional Formatting
    'If Yearchange < 0 then Cell Background Color is Red Else Cell Background Color is Green
        If YearChange < 0 Then
            Cells(OutputCount, 13).Interior.Color = vbRed
        Else
            Cells(OutputCount, 13).Interior.Color = vbGreen
        End If

    'The percentage change from the opening price at the beginning of a given year to the closing price at the end of that year.
    'Cells(OutputCount, 14) = (sClose - sOpen) * 100 / sOpen
    Cells(OutputCount, 14).Value = FormatPercent(PercentChange, 2)
        If PercentChange < 0 Then
            Cells(OutputCount, 14).Interior.Color = vbRed
        Else
            Cells(OutputCount, 14).Interior.Color = vbGreen
        End If






End Function

Sub GetGreatest()
Dim gRng As Range
Dim rngString As String
Dim LastRow
Dim MinIncrease As Long
Dim MaxIncrease As Long
Dim MaxStockVolume As Long
With ActiveSheet
        LastRow = .Cells(.Rows.Count, "N").End(xlUp).Row
        LastColumn = .Cells(1, .Columns.Count).End(xlToLeft).Column

rngString = "N1:N" & LastRow
Set gRng = Range(rngString)
MaxIncrease = WorksheetFunction.Match(WorksheetFunction.Max(gRng), gRng, 0)
MinIncrease = WorksheetFunction.Match(WorksheetFunction.Min(gRng), gRng, 0)

'MsgBox MaxIncrease & " " & MinIncrease
'MATCH(MAX(N1:N3001),N1:N3001,0)
.Range("S2").Value = FormatPercent(WorksheetFunction.Max(gRng), 2)
.Range("S3").Value = FormatPercent(WorksheetFunction.Min(gRng), 2)
rngString = "L1:L" & LastRow
Set gRng = Range(rngString)
.Range("S4").Value = WorksheetFunction.Max(gRng)
MaxStockVolume = WorksheetFunction.Match(WorksheetFunction.Max(gRng), gRng, 0)
'MsgBox "Max Increase " & MaxIncrease & " " & "Min Increase " & MinIncrease & "Max Stock Volume " & MaxStockVolume
.Range("R2").Value = Cells(MaxIncrease, 9).Value
.Range("R3").Value = Cells(MinIncrease, 9).Value
.Range("R4").Value = Cells(MaxStockVolume, 9).Value

.Range("R2:S4").Columns.AutoFit
End With

End Sub




Function CreateHeaderRow():
'get blank column
   Dim LastRow As Long
    Dim LastColumn As Long
    Dim StartColumn As Long
    Dim HeaderRow As Long
    
    'With ActiveSheet
     '   LastRow = .Cells(.Rows.Count, "A").End(xlUp).Row
      '  LastColumn = .Cells(1, .Columns.Count).End(xlToLeft).Column
    'End With
      'go 1 over from blank column
    StartColumn = 9
    HeaderRow = 1
    'populate header row
    With ActiveSheet
    'Ticker,Yearly Change, Percent Change,Total Stock Volume
    .Cells(HeaderRow, StartColumn).Value = "Ticker"
    .Cells(HeaderRow, StartColumn + 1).Value = "Year Open"
    .Cells(HeaderRow, StartColumn + 2).Value = "Year Close"
    .Cells(HeaderRow, StartColumn + 3).Value = "Total Stock Volume"
    .Cells(HeaderRow, StartColumn + 4).Value = "Yearly Change"
    .Cells(HeaderRow, StartColumn + 5).Value = "Percent Change"
    'go 3 columns over then Ticker, Value
    .Cells(HeaderRow, StartColumn + 9).Value = "Ticker"
    .Cells(HeaderRow, StartColumn + 10).Value = "Value"
    'go 1 row down and 2 columns to the left
    'Greatest % Increase
    .Cells(HeaderRow + 1, StartColumn + 8) = "Greatest % Increase"
    'go 1 row down
    'Greatest% Decrease
    .Cells(HeaderRow + 2, StartColumn + 8) = "Greatest % Decrease"
    'go 1 row down
    'Greatest Total Volume
    .Cells(HeaderRow + 3, StartColumn + 8) = "Greatest Total Volumne"
    .Range("I1:N1").Columns.AutoFit
    .Range("Q1:S4").Columns.AutoFit
    
    End With
    
    
    
    

'.Range("H6:H" & lastrow2).NumberFormat = "0.00%"

End Function


Sub Button1_Click()
'call sub to loop through worksheets
    Call WorksheetLoop
End Sub

Sub Button2_Click():
'declare variables
Dim rng As Range
Dim cell As Range
Dim rngString As String
Dim LastRow As Long
'loop through worksheets and clear ticker summary contents and header
Dim WS_Count As Integer
Dim I As Integer

         
         WS_Count = ActiveWorkbook.Worksheets.Count

         ' Begin the loop.
         For I = 1 To WS_Count
            Worksheets(I).Activate
            LastRow = Cells(Rows.Count, "I").End(xlUp).Row
            'clear contents of columns I to Column n
            rngString = "I2:N" & LastRow
            'Set range to clear
            Set rng = Range(rngString)
            'rng.Interior.Color = xlNone
            rng.ClearContents
            Set rng = Range("R2:S4")
            rng.ClearContents
            'set cell interior color back to default for columns M to N
            Columns("M:N").Select
                With Selection.Interior
                .Pattern = xlNone
                .TintAndShade = 0
                .PatternTintAndShade = 0
                End With
            'Selection.Clear
            Range("I1").Select
            Call CreateHeaderRow
           
         Next I
Worksheets(1).Activate





'Loop through each cell in range
'For Each cell In rng
 '   cell.ClearContents
'Next cell

'set interior color to nothing for columns I to column N
'clear contents of column q from row 1 to 4
'clear header row from column i to column p
'go back to first sheet when done

End Sub


