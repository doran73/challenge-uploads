Attribute VB_Name = "Module1"

Sub WorksheetLoop():

         Dim WS_Count As Integer
         Dim I As Integer
         Dim StartTime As Double
         Dim SecondsElapsed As Double
         Dim SheetResults As String
         Dim SheetCount As Long
         

         ' Set WS_Count equal to the number of worksheets in the active
         ' workbook.
         WS_Count = ActiveWorkbook.Worksheets.Count

         ' Begin the loop.
         For I = 1 To WS_Count

            ' Insert your code here.
            'MsgBox "Processing Sheet: " & I & "OF: " & WS_Count
            'start timer
            StartTime = Timer
            SheetCount = ActiveWorkbook.Worksheets(I).Cells(Rows.Count, 1).End(xlUp).Row
            Call ProcessSheet(I, SheetCount)
            SheetResults = SheetResults & "Sheet Name " & ActiveWorkbook.Worksheets(I).Name & ": " & SheetCount & " Rows Processed" & vbCrLf

            'MsgBox ActiveWorkbook.Worksheets(I).Name
            'MsgBox ActiveWorkbook.Worksheets(I).Cells(Rows.Count, 1).End(xlUp).Row


         Next I
       'Calculate how much time has passed
        SecondsElapsed = Round(Timer - StartTime, 2)
        'output time elapsed to run code in a message box
        
        Worksheets(1).Activate
        MsgBox "All Done in " & SecondsElapsed & " seconds " & vbCrLf & SheetResults
        
      End Sub


Sub ProcessSheet(SheetNum As Integer, LastRow As Long):
'set focus on the worksheet number that is passed to sub
Worksheets(SheetNum).Activate
Call CreateHeaderRow
Dim Ticker As String
Dim Ticker2 As String
Dim StartRow As Long
Dim EndRow As Long
Dim OutputCount As Long
'Dim LastRow As Long
'LastRow = Cells(Rows.Count, 1).End(xlUp).Row

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
Dim sHigh As Double
Dim sLow As Double
Dim PercentChange2 As Double
Dim YearChange2 As Double

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
    'get the Max Value for High column
    Cells(OutputCount, 21).Value = TickerValue
    RangeString = "D" & StartRow & ":" & "D" & EndRow
    Set rng = Range(RangeString)
    sHigh = WorksheetFunction.Max(rng)
    Cells(OutputCount, 22).Value = sHigh
    
    'get the Min Value for Low Column
    RangeString = "E" & StartRow & ":" & "E" & EndRow
    Set rng = Range(RangeString)
    sLow = WorksheetFunction.Min(rng)
    Cells(OutputCount, 23).Value = sLow
    YearChange2 = sHigh - sLow
    PercentChange2 = (sHigh - sLow) / sLow
    Cells(OutputCount, 24).Value = YearChange2
    Cells(OutputCount, 25).Value = FormatPercent(PercentChange2, 2)
    
    'If Yearchange < 0 then Cell Background Color is Red Else Cell Background Color is Green
        'If YearChange2 < 0 Then
        '    Cells(OutputCount, 24).Interior.Color = vbRed
        'Else
        '    Cells(OutputCount, 24).Interior.Color = vbGreen
        'End If

    'The percentage change from the opening price at the beginning of a given year to the closing price at the end of that year.
    'Cells(OutputCount, 14) = (sClose - sOpen) * 100 / sOpen
    'Cells(OutputCount, 14).Value = FormatPercent(PercentChange, 2)
     '   If PercentChange2 < 0 Then
     '       Cells(OutputCount, 25).Interior.Color = vbRed
     '   Else
     '       Cells(OutputCount, 25).Interior.Color = vbGreen
     '   End If
    





End Function

Function GetGreatest():
'populate Greatest % increase, Greatest % Decrease and Greatest Total Volume for the current worksheet
Dim gRng As Range
Dim rngString As String
Dim LastRow
Dim MinIncrease As Long
Dim MaxIncrease As Long
Dim MaxStockVolume As Long
'get last row for percent change column to be used in a range
    With ActiveSheet
        LastRow = .Cells(.Rows.Count, "N").End(xlUp).Row
        LastColumn = .Cells(1, .Columns.Count).End(xlToLeft).Column

        rngString = "N1:N" & LastRow
        Set gRng = Range(rngString)
        'get the row number where the max value came from
        MaxIncrease = WorksheetFunction.Match(WorksheetFunction.Max(gRng), gRng, 0)
        'get the rownumber of where the min value came from
        MinIncrease = WorksheetFunction.Match(WorksheetFunction.Min(gRng), gRng, 0)

        'MsgBox MaxIncrease & " " & MinIncrease
        'MATCH(MAX(N1:N3001),N1:N3001,0)
        'populate cell with max and min value
        .Range("S2").Value = FormatPercent(WorksheetFunction.Max(gRng), 2)
        .Range("S3").Value = FormatPercent(WorksheetFunction.Min(gRng), 2)
        'set range to Total Stock Volume column
        rngString = "L1:L" & LastRow
        Set gRng = Range(rngString)
        .Range("S4").Value = WorksheetFunction.Max(gRng)
        'find row number where the max stock volume came from
        MaxStockVolume = WorksheetFunction.Match(WorksheetFunction.Max(gRng), gRng, 0)
        'MsgBox "Max Increase " & MaxIncrease & " " & "Min Increase " & MinIncrease & "Max Stock Volume " & MaxStockVolume
        'get the ticker for the corresponding values using row number
        .Range("R2").Value = Cells(MaxIncrease, 9).Value
        .Range("R3").Value = Cells(MinIncrease, 9).Value
        .Range("R4").Value = Cells(MaxStockVolume, 9).Value
        'auto fit columns
        .Range("R2:S4").Columns.AutoFit
        rngString = "U1:Y" & LastRow
        .Sort.SortFields.Add Key:=Range("Y1"), Order:=xlDescending
        .Sort.SetRange Range(rngString)
        .Sort.Header = xlYes
        .Sort.Apply
        .Columns("U:Y").EntireColumn.AutoFit
        
    End With

End Function




Function CreateHeaderRow():
Dim LastRow As Long
Dim LastColumn As Long
Dim StartColumn As Long
Dim HeaderRow As Long
    
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
        .Cells(HeaderRow, StartColumn + 12).Value = "Ticker"
        .Cells(HeaderRow, StartColumn + 13).Value = "Year High"
        .Cells(HeaderRow, StartColumn + 14).Value = "Year Low"
        .Cells(HeaderRow, StartColumn + 15).Value = "Yearly Change"
        .Cells(HeaderRow, StartColumn + 16).Value = "Percent Change"
        
        'go 1 row down and 2 columns to the left
        'Greatest % Increase
        .Cells(HeaderRow + 1, StartColumn + 8) = "Greatest % Increase"
        'go 1 row down
        'Greatest% Decrease
        .Cells(HeaderRow + 2, StartColumn + 8) = "Greatest % Decrease"
        'go 1 row down
        'Greatest Total Volume
        .Cells(HeaderRow + 3, StartColumn + 8) = "Greatest Total Volumne"
        
        '.Range("I1:N1").Columns.AutoFit
        '.Range("Q1:S4").Columns.AutoFit
        
    
    End With
    
    
    
    

'.Range("H6:H" & lastrow2).NumberFormat = "0.00%"

End Function


Sub Button1_Click():
'call sub to loop through worksheets
    Call WorksheetLoop
End Sub

Sub Button2_Click():
'when the reset sheets button is clicked it will clear all the values from Column i to Column n and reset the cell background color to the default
'this will be done to all sheets
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
            'Clear greatest values
            Set rng = Range("R2:S4")
            rng.ClearContents
            rngString = "U2:Y" & LastRow
            Set rng = Range(rngString)
            rng.ClearContents
            'set cell interior color back to default for columns M to N
            Columns("M:N").Select
                With Selection.Interior
                .Pattern = xlNone
                .TintAndShade = 0
                .PatternTintAndShade = 0
                End With
                
             Columns("X:Y").Select
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

End Sub


