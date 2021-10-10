<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ReportBalanceSheetControl.ascx.cs" Inherits="Admin_AdminControls_ReportBalanceSheet" %>
<style>
    #tblBalanceSheet {
        border:1px solid #4178BE;
    }
        #tblBalanceSheet thead {
            border:1px solid #4178BE;
            background-color:#4178BE;
            color:white;
            font-size:17px;
        }
    #tblBalanceSheet thead tr th {
        padding:10px;
    }
    #tblBalanceSheet tbody tr {
        padding:10px;        
    }
    #tblBalanceSheet tbody tr td{
        padding:10px;
        width:200px;
    }
    .subtotal {
        
	border: 2px solid;
	background-color: wheat;
	color: black;
    }
</style>
<div id="ReportBalanceSheet" class="innerContainer container">
    <div class="lead" data-name="buttonsDiv-ReportBalanceSheet" style="width: 100%; height: 60px;">  
        
        <input class="btn" type="button" title="Back" value="Back" style="display: none" onclick="manageSection('Show BalanceSheet', 'ReportBalanceSheet-Add', 'content-ReportBalanceSheet', this);" />
        <input class="btn" type="button"  title="ShowReportBalanceSheet" value="Show BalanceSheet" onclick="manageSection('Back', 'ReportBalanceSheet-Show', 'content-ReportBalanceSheet', this); ShowBalanceSheet();" />        
        <hr style="margin-top: 10px; margin-bottom: 20px; float: left; width: 100%" />
    </div>
    <div id="content-ReportBalanceSheet">
        <div id="ReportBalanceSheet-Add">
            <div>
            <div class="row">                
                <div class="form-group col-xs-6">                    
                    <label style="display: inline-block;
    margin-bottom: 5px;
    font-weight: bold;
    float: left;
    width: 50px;
    line-height: 60px;">Date</label>
                    <input type="text" class="form-control col-md-2" style="display:inline-block;width:50%;margin:13px;"  id="txtBalanceSheetDate" placeholder="">                    
                      <input class="btn" type="button" title="Sumbit" value="Submit" style="margin-left:10px;" onclick="SearchBalanceSheet();" />                    
                     <input class="btn" type="button" title="Save" value="Save Sheet" style="margin-left:10px; background-color:forestgreen;color:white;border:1px solid forestgreen" disabled="disabled" id="btnSaveBalanceSheet" onclick="javascript: AddBalanceSheet();" />                    
                </div>
                                           
                </div>
                </div>
            <div class="row" style="margin-left:20px;margin-bottom:10px;">
                <div class="col-md-6">
                <table id="tblBalanceSheet" style="">
                <thead>
                    <tr><th>Title</th>
                        <th>Amount</th>
                    </tr></thead>
                <tbody>
                    <tr><td>Initial Investment</td> <td><input id="InitialInvestment" type="text" value="3400000"  /></td></tr>
                    <tr><td>HT Balance</td> <td id="HTBal">0</td></tr>
                    <tr><td>S&R Balance</td> <td id="SRBal">0</td></tr>
                    
                    <tr class="subtotal"><td>Sub Total</td> <td id="InvestmentTotal">0</td></tr>
                    <tr><td>Credit Balance</td> <td id="CreditBal">0</td></tr>
                    <tr class="subtotal"><td>Sub Total</td> <td id="CreditTotal">0</td></tr>
                    <tr><td>Dealer's Balance</td> <td id="DealerBal">0</td></tr>
                    <tr class="subtotal"><td>Sub Total</td> <td id="DealerTotal">0</td></tr>                    
                    <tr><td>Fare</td> <td id="Fare">0</td></tr>
                    <tr class="subtotal"><td>Sub Total</td> <td id="FareTotal">0</td></tr>
                    <tr><td>Expense</td> <td id="Expense">0</td></tr>
                    <tr class="subtotal" style="background-color:forestgreen;color:white; border: 1px solid #4178BE "><td>Sub Total</td> <td id="Expensetotal">0</td></tr>
                    
                    
                </tbody>     
                </table>
                    </div>
            </div>
        </div>
        <div id="ReportBalanceSheet-Show" style="display: none;">
            detail report
        </div>
    </div>
</div>

<script>

    //--------------------------------- ReportBalanceSheet ---------------------------------

    $(document).ready(function () {
       
        $("#txtBalanceSheetDate").datepicker({
            changeMonth: true,
            changeYear: true
        });
        $.blockUI();
      //  $("#txtBalanceSheetDate").datepicker("setDate", new Date());
      //  GetBalanceSheetDate();
    });
    
    function GetBalanceSheetDate()
    {
        $.ajax({
            type: "POST",
            url: "WebMethods.aspx/GetBalanceSheetDate",
            data: "{}",//"{\"ACC_ID\" :" + null + ", \"ACC_TYPE_ID\" :" + 2 + ",}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
                
                if (msg.d.Item1 == 0) {                
                    $("#txtBalanceSheetDate").val(msg.d.Item3[0].PURCHASE_DATE);
                }
                else
                    alert("Error Saving Sale:" + msg.Item2);
            },
            error: function () {
                alert("Some Error occured in getting ReportBalanceSheet Date. Please contact Support team");
            }
        });

    }

    function SearchBalanceSheet() {
        if ($('#txtBalanceSheetDate').val() == "")
        {
            alert("Select Date");
            return
        }

        $.ajax({
            type: "POST",
            url: "WebMethods.aspx/SearchBalanceSheet",
            data: "{'date':'"+$('#txtBalanceSheetDate').val()+"'}",//"{\"ACC_ID\" :" + null + ", \"ACC_TYPE_ID\" :" + 2 + ",}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
                if (msg.d.Item1 == 0) {
                    var InitialInvestment = $('#InitialInvestment').val() * -1;//-3400000;
                    var HTBal = msg.d.Item3[0].HT_BAL
                    var SRBal = msg.d.Item3[0].SR_BAL;
                    var InvestmentTotal = InitialInvestment + HTBal + SRBal;

                    var CreditBal = msg.d.Item3[0].CREDIT_BAL;
                    var CreditTotal = InvestmentTotal < 0 ? InvestmentTotal - CreditBal : InvestmentTotal + CreditBal;                    

                    var DealerBal = msg.d.Item3[0].DEALER_BAL;
                    var DealerTotal = CreditTotal < 0 ? CreditTotal + DealerBal : CreditTotal - DealerBal;
                    DealerTotal = DealerTotal < 0 ? DealerTotal * -1 : DealerTotal;

                    var Fare = msg.d.Item3[0].FARE == null ? 0 : msg.d.Item3[0].FARE;
                    var CTTemp = CreditTotal < 0 ? CreditTotal * -1 : CreditTotal
                    var FareTotal = CTTemp > DealerBal ? DealerTotal + Fare : DealerTotal - Fare;

                    var Expense = msg.d.Item3[0].EXPENSE == null ? 0 : msg.d.Item3[0].EXPENSE;
                    var ExpneseTotal = FareTotal < 0 ? FareTotal + Expense : FareTotal - Expense;

                   // $('#InitialInvestment').text((InitialInvestment < 0 ? InitialInvestment * -1 : InitialInvestment));
                    $('#HTBal').text(HTBal);
                    $('#SRBal').text(SRBal);
                    $('#InvestmentTotal').text(InvestmentTotal < 0 ? InvestmentTotal * -1 : InvestmentTotal);                    
                    $('#CreditBal').text(CreditBal);
                    $('#CreditTotal').text(CreditTotal < 0 ? CreditTotal * -1 : CreditTotal);
                    $('#DealerBal').text(DealerBal);
                    $('#DealerTotal').text(DealerTotal < 0 ? DealerTotal * -1 : DealerTotal);
                    $('#Fare').text(Fare);
                    $('#FareTotal').text(FareTotal < 0 ? FareTotal * -1 : FareTotal);
                    $('#Fare').text(Fare);
                    $('#FareTotal').text(FareTotal < 0 ? FareTotal * -1 : FareTotal);
                    $('#Expense').text(Expense);
                    $('#Expensetotal').text(ExpneseTotal < 0 ? ExpneseTotal * -1 : ExpneseTotal);

                    $('#btnSaveBalanceSheet').removeAttr('disabled');
                }
                else
                {
                    alert("Error: " + msg.d.Item2);
                }
                    
            },
            error: function () {
                      alert("Some Error occured in getting ReportBalanceSheet Date. Please contact Support team");
                  }
        });
    }
    
    function AddBalanceSheet() {

        var BalanceSheet = {};               

        BalanceSheet.SHEET_ID = 0;
        BalanceSheet.SHEET_DATE = $('#txtBalanceSheetDate').val();
        BalanceSheet.INITIAL_INVESTMENT = $('#InitialInvestment').val(); //$('input[id$=txtSlipDate]').val();
        BalanceSheet.HT_BALANCE = $('#HTBal').text();
        BalanceSheet.SR_BALANCE = $('#SRBal').text();
        BalanceSheet.CREDIT_BALANCE = $('#CreditBal').text();
        BalanceSheet.DEALERS_BALANCE = $('#DealerBal').text();
        BalanceSheet.FARE = $('#Fare').text();
        BalanceSheet.EXPENSE = $('#Expense').text();

        $.ajax({
            type: "POST",
            url: "WebMethods.aspx/AddBalanceSheet",
            data: JSON.stringify({ objBalanceSheet: BalanceSheet }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
                if (msg.d.Item1 == 0) {
                    alert("BalanceSheet Saved Successfully");
                    //clearContent('#ReportBalanceSheet');
                    $('#btnSaveBalanceSheet').attr('disabled', 'disabled');
                }
                else
                    alert("Error Saving Sale:" + msg.Item2);

            },
            error: function ()
            {
                alert("Error in adding balance sheet. Please contact support team");
            }
        });
    }

    function ShowBalanceSheet() {
                
        $.ajax({
            type: "POST",
            url: "WebMethods.aspx/ShowBalanceSheet",
            data: "{}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: successShowReportAccountDetail,
            error: ErrorShowReportAccountDetail
        });
    }

    function successShowReportAccountDetail(data) {

        $('#ReportBalanceSheet-Show').html(generateTable(data.d.Item3));
        SetDataTable('#tblDatatable');
    }
    function generateTable(data) {
        var table = "<div class='toolbar'></div>";
        table += "<table id='tblDatatable' cellspacing ='1px' style='width:100%'>";
        table += "<thead><tr>";

        table += "<th style='width:30px'>Sr.</th>";
        table += "<th>Date</th>";
        table += "<th>Initial Investment</th>";
        table += "<th>HT Balance</th>";
        table += "<th>S&R Balance</th>";
        table += "<th>Credit Balance</th>";
        table += "<th>Dealers Balance</th>";
        table += "<th>Sub Total</th>";
        table += "<th>Fare</th>";
        table += "<th>Sub Total</th>";
        table += "<th>Expense</th>";
        table += "<th>Total</th>";
        table += "<th>Delete</th>";

        table += "</tr></thead><tbody>";
       
        var serial = 0;
        for (var i = 0; i < data.length; i++) {

            var InitialInvestment = data[i].INITIAL_INVESTMENT > 0 ? data[i].INITIAL_INVESTMENT * -1 : data[i].INITIAL_INVESTMENT;
            var HTBal = data[i].HT_BALANCE;
            var SRBal = data[i].SR_BALANCE;
            var InvestmentTotal = InitialInvestment + HTBal + SRBal;

            var CreditBal = data[i].CREDIT_BALANCE;
            var CreditTotal = InvestmentTotal < 0 ? InvestmentTotal - CreditBal : InvestmentTotal + CreditBal;


            var DealerBal = data[i].DEALERS_BALANCE;
            var DealerTotal = CreditTotal < 0 ? CreditTotal + DealerBal : CreditTotal - DealerBal;
            DealerTotal = DealerTotal < 0 ? DealerTotal * -1 : DealerTotal;

            var Fare = data[i].FARE == null ? 0 : data[i].FARE;
            var CTTemp = CreditTotal < 0 ? CreditTotal * -1 : CreditTotal
            var FareTotal = CTTemp > DealerBal ? DealerTotal + Fare : DealerTotal - Fare;

            var Expense = data[i].EXPENSE == null ? 0 : data[i].EXPENSE;
            var ExpneseTotal = FareTotal < 0 ? FareTotal + Expense : FareTotal - Expense;
            serial++;
            table += "<tr>";

            table += "<td>" + serial + "</td>";
            table += "<td>" + msToTime(data[i].SHEET_DATE) + "</td>";
            table += "<td>" + data[i].INITIAL_INVESTMENT + "</td>";
            table += "<td>" + data[i].HT_BALANCE + "</td>";
            table += "<td>" + data[i].SR_BALANCE + "</td>";
            table += "<td>" + data[i].CREDIT_BALANCE + "</td>";
            table += "<td>" + data[i].DEALERS_BALANCE + "</td>";
            table += "<td>" + (DealerTotal < 0 ? DealerTotal * -1 : DealerTotal) + "</td>";
            table += "<td>" + data[i].FARE + "</td>";
            table += "<td>" + (FareTotal < 0 ? FareTotal * -1 : FareTotal) + "</td>";
            table += "<td>" + data[i].EXPENSE + "</td>";
            table += "<td>" + (ExpneseTotal < 0 ? ExpneseTotal * -1 : ExpneseTotal) + "</td>";
            //table += "<td><a style='cursor:pointer;color:red' data-id='" + data[i].Sale_ID + "' onclick='editSale(this)'><img src='../img/img_edit.png' style='width:30px;height:30px;' />  </a> </td>";
            //if (data[i].IS_ACTIVE = true) {
           // if (i == 0) {
            table += "<td><a style='cursor:pointer;color:red' data-id='" + data[i].SHEET_ID + "' onclick='DeleteBalanceSheet(this)'>Delete</a></td>";
            //}
            //else {
              //  table += "<td id='" + data[i].SHEET_ID + "'></td>";
            //}            

            table += "</tr>";
        }
        table + "</tbody>";
        table += "</table>";
        return table;

    }
    function ErrorShowReportAccountDetail() {

        alert("Some Error occured in showing ReportBalanceSheet. Please contact Support team");

    }

    function DeleteBalanceSheet(aTag) {

        var ReportBalanceSheetid = $(aTag).data('id');
        $.ajax({
            type: "POST",
            url: "WebMethods.aspx/DeleteBalanceSheet",
            data: "{'id':'" + ReportBalanceSheetid + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: successdelete_ReportBalanceSheet,
            error: Errordelete_ReportBalanceSheet
        });

    }
    function successdelete_ReportBalanceSheet(msg) {

        if (msg.d.Item1 == 0) {
            alert("Deleted successfully");
            ShowBalanceSheet();
        }
        else {
            alert("Error Deleting ReportBalanceSheet" + msg.d.Item2);
        }
            
    }
    function Errordelete_ReportBalanceSheet() {

        alert("Error occured in deleting. Please Contact support team");
    }


    
    function SetDataTable(tbl) {
        var totalcolumns = $(tbl + " tr:nth-child(1) th").length;
        //if ($("#tblFellows tr").length < 2)
        //   return;
        var columns = [];
        columns.push({ "bSortable": false });
        for (var i = 1; i < totalcolumns; i++) {

            columns.push({ "bSortable": true });
        }
        oTable = $(tbl).dataTable({
            "bJQueryUI": true,
            "sPaginationType": "full_numbers",
            "bSearchable": true,
            "aoColumns": columns
        });


        $("div.toolbar").html('<b><a id="exportdatatable" onclick="ExportToExcel(\'BalanceSheet\',$(\'#exportdatatable\').parent().parent().next().children(\'table\').html())" style="cursor:pointer;text-decoration: underline;font-style: italic;font-size: 16px;font-family: -webkit-pictograph;">Export to Excel</a></b>');
    }
    //--------------------------------- ReportBalanceSheet end ---------------------------------
</script>
