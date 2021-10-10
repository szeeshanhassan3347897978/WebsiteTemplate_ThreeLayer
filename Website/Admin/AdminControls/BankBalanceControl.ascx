<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BankBalanceControl.ascx.cs" Inherits="Admin_AdminControls_BankBalance" %>
<style>
    #BankBalance-Add input[type=text] {
        width: 250px;
    }

    #BankBalance-Add select {
        width: 250px;
    }

    #BankBalance-Add .form-group {
        margin-bottom: 15px;
    }

    #BankBalance-Add label {
        width: 110px;
        padding-left: 20px;
    }
</style>
<div id="BankBalance" class="" style="height: 450px; margin-left: 15px;">
    <div class="lead" data-name="buttonsDiv-BankBalance" style="width: 100%; height: 60px;">
        <input class="btn" type="button" title="Back" value="Back" style="display: none" onclick="manageSection('Show BankBalance,Add BankBalance', 'BankBalance-Add', 'content-BankBalance', this);" />
        <input class="btn" type="button" title="Add BankBalance" value="Add BankBalance" onclick="AddBankBalance()" />
        <input class="btn" type="button" title="Show BankBalance" value="Show BankBalance" onclick="manageSection('Show BankBalance,Back', 'BankBalance-Show', 'content-BankBalance', this); ShowBankBalance()" />
        <hr style="margin-top: 10px; margin-bottom: 20px; float: left; width: 100%" />
    </div>
    <div id="content-BankBalance">
        <div id="BankBalance-Add">
            <div class="form-inline">
                <div class="form-group">
                            <label>B.B Date</label>
                            <input type="text" class="form-control" id="txtBB_DATE" placeholder="" >
                        </div>
                <div class="form-group">
                    <label>B.S Amount</label>
                    <input type="text" class="form-control" id="txtBALANCESHEET_AMOUNT" placeholder="" onchange="setBalance()">
                </div>               
                <br />  
                                       
                <div class="form-group">
                    <label>In Hand</label>
                    <input type="text" class="form-control" id="txtBALANCE_IN_HAND" placeholder="" onchange="setBalance()">
                </div>
                <div class="form-group">
                    <label>ABL</label>
                    <input type="text" class="form-control" id="txtABL" placeholder="" onchange="setBalance()">
                </div>
                <div class="form-group">
                    <label>UBL</label>
                    <input type="text" class="form-control" id="txtUBL" placeholder="" onchange="setBalance()">
                </div>
                <div class="form-group">
                    <label>At Pump</label>
                    <input type="text" class="form-control" id="txtPUMP" placeholder="" onchange="setBalance()">
                </div>
                <div class="form-group">
                    <label>Balance 056</label>
                    <input type="text" class="form-control" id="txtBALANCE_056" placeholder="" onchange="setBalance()">
                </div>
                 
                <div class="form-group">
                    <label>Other</label>
                    <input type="text" class="form-control" id="txtOTHER" placeholder="" onchange="setBalance()">
                </div>
                <br />
               
                <div class="form-group">
                    <label>Total Balance</label>
                    <input type="text" class="form-control" disabled="disabled" id="txtTOTAL_BALANCE" placeholder="" onchange="setBalance()">
                </div>
                <div class="form-group">
                    <label>Remaining</label>
                    <input type="text" class="form-control" disabled="disabled"  id="txtREMAINING_BALANCE" placeholder="" onchange="setBalance()">
                </div>
                <br />
                <div class="form-group">
                    <label>Reason</label>
                    <input type="text" class="form-control" id="txtREASON" placeholder="">
                </div>
            </div>
        </div>

        <div id="BankBalance-Show" style="display: none;">
            Active
        </div>
    </div>
</div>

<script>

    //--------------------------------- BankBalance ---------------------------------

    $(document).ready(function () {

        $("#txtBB_DATE").datepicker({
            changeMonth: true,
            changeYear: true
        });

        $("#txtBB_DATE").datepicker("setDate", new Date());
        
    });
    function setBalance()
    {
        
        var txtBALANCESHEET_AMOUNT = $('#txtBALANCESHEET_AMOUNT').val() == "" ? 0 : $('#txtBALANCESHEET_AMOUNT').val();
        var txtBALANCE_IN_HAND = $('#txtBALANCE_IN_HAND').val() == "" ? 0 : $('#txtBALANCE_IN_HAND').val();
        var txtABL = $('#txtABL').val() == "" ? 0 : $('#txtABL').val();
        var txtUBL = $('#txtUBL').val() == "" ? 0 : $('#txtUBL').val();
        var txtPUMP = $('#txtPUMP').val() == "" ? 0 : $('#txtPUMP').val();
        var txtBALANCE_056 = $('#txtBALANCE_056').val() == "" ? 0 : $('#txtBALANCE_056').val();
        var txtOTHER = $('#txtOTHER').val() == "" ? 0 : $('#txtOTHER').val();
        var txtTOTAL_BALANCE = parseInt(txtBALANCE_IN_HAND) + parseInt(txtABL) + parseInt(txtUBL) + parseInt(txtPUMP) + parseInt(txtBALANCE_056) + parseInt(txtOTHER);
        $('#txtTOTAL_BALANCE').val(txtTOTAL_BALANCE);
        $('#txtREMAINING_BALANCE').val(parseInt(txtTOTAL_BALANCE) - parseInt(txtBALANCESHEET_AMOUNT));        
        
    }
    function AddBankBalance() {       

        setBalance();

        var BankBalance = {};
        
        BankBalance.BB_DATE = $('input[id$=txtBB_DATE]').val();
        BankBalance.BALANCESHEET_AMOUNT = $('input[id$=txtBALANCESHEET_AMOUNT]').val();
        BankBalance.BALANCE_IN_HAND = $('input[id$=txtBALANCE_IN_HAND]').val();
        BankBalance.ABL = $('input[id$=txtABL]').val();
        BankBalance.UBL = $('input[id$=txtUBL]').val();
        BankBalance.PUMP = $('input[id$=txtPUMP]').val();
        BankBalance.BALANCE_056 = $('input[id$=txtBALANCE_056]').val();
        BankBalance.OTHER = $('input[id$=txtOTHER]').val();
        BankBalance.TOTAL_BALANCE = $('input[id$=txtTOTAL_BALANCE]').val();
        BankBalance.REMAINING_BALANCE = $('input[id$=txtREMAINING_BALANCE]').val();
        BankBalance.REASON = $('input[id$=txtREASON]').val();

        $.ajax({
            type: "POST",
            url: "WebMethods.aspx/AddBankBalance",
            data: JSON.stringify({ objBankBalance: BankBalance }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
                if (msg.d.Item1 == 0) {
                    alert("BankBalance Saved Successfully");
                    clearContent('#BankBalance');
                }
                else
                    alert("Error Saving BankBalance" + msg.d.Item2);

            },
            error: ErrorAddBankBalance
        });
    }

    function clearContent(div) {
        var ref_id = div + ' input[type="text"]:visible, textarea:visible, input[type="file"]:visible'
        $(ref_id).val('');
    }
    function clearContentBankBalance(div) {
        var ref_id = div + ' input[type="text"]:visible, textarea:visible, input[type="file"]:visible'
        $(ref_id).val('');

    }
    function ErrorAddBankBalance() {
        alert("Some Error occured in adding BankBalance. Please contact Support team");
    }
    function ShowBankBalance() {

        $.ajax({
            type: "POST",
            url: "WebMethods.aspx/ShowBankBalance",
            data: "{}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: successShowBankBalance,
            error: ErrorShowBankBalance
        });
    }

    function successShowBankBalance(data) {

        $('#BankBalance-Show').html(generateTable(data.d.Item3));
        SetDataTable('#tblDatatable');
    }
    function generateTable(data) {
        var table = "<div class='toolbar'></div>";
        table += "<table id='tblDatatable' cellspacing ='1px' style='width:100%'>";
        table += "<thead><tr>";
        
        table += "<th>Date</th>";
        table += "<th>BalanceSheet</th>";
        table += "<th>In Hand</th>";
        table += "<th>ABL</th>";
        table += "<th>UBL</th>";
        table += "<th>Pump</th>";
        table += "<th>BAL_056</th>";
        table += "<th>Other</th>";
        table += "<th>Total</th>";
        table += "<th>Remaining</th>";
        table += "<th>Reason</th>";
        table += "<th>Delete</th>";

        table += "</tr></thead><tbody>";

        var serial = 0;
        for (var i = 0; i < data.length; i++) {
            serial++;
            table += "<tr>";            
            table += "<td>" + msToTime(data[i].BB_DATE) + "</td>";
            table += "<td>" + (data[i].BALANCESHEET_AMOUNT == null ? "" : data[i].BALANCESHEET_AMOUNT) + "</td>";
            table += "<td>" + (data[i].BALANCE_IN_HAND == null ? "" : data[i].BALANCE_IN_HAND) + "</td>";
            table += "<td>" + (data[i].ABL == null ? "" : data[i].ABL) + "</td>";
            table += "<td>" + (data[i].UBL == null ? "0" : data[i].UBL) + "</td>";
            table += "<td>" + (data[i].PUMP == null ? "0" : data[i].PUMP) + "</td>";
            table += "<td>" + (data[i].BALANCE_056 == null ? "0" : data[i].BALANCE_056) + "</td>";
            table += "<td>" + (data[i].OTHER == null ? "0" : data[i].OTHER) + "</td>";
            table += "<td>" + (data[i].TOTAL_BALANCE == null ? "0" : data[i].TOTAL_BALANCE) + "</td>";
            table += "<td>" + (data[i].REMAINING_BALANCE == null ? "0" : data[i].REMAINING_BALANCE) + "</td>";
            table += "<td>" + (data[i].REASON == null ? "0" : data[i].REASON) + "</td>";
            //table += "<td><a style='cursor:pointer;color:red' data-id='" + data[i].BankBalance_ID + "' onclick='editBankBalance(this)'><img src='../img/img_edit.png' style='width:30px;height:30px;' />  </a> </td>";

            table += "<td><a style='cursor:pointer;color:red' data-id='" + data[i].BB_ID + "' onclick='deleteBankBalance(this)'>Delete</a></td>";

            table += "</tr>";
        }
        table + "</tbody>";
        table += "</table>";
        return table;

    }
    function ErrorShowBankBalance() {

        alert("Some Error occured in showing BankBalance. Please contact Support team");

    }

    function deleteBankBalance(aTag) {

        var BankBalanceid = $(aTag).data('id');
        $.ajax({
            type: "POST",
            url: "WebMethods.aspx/DeleteBankBalance",
            data: "{'id':'" + BankBalanceid + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: successdelete_BankBalance,
            error: Errordelete_BankBalance
        });

    }
    function successdelete_BankBalance(msg) {

        if (msg.d.Item1 == 0) {
            alert("Deleted successfully");
            ShowBankBalance();
        }
        else {
            alert("Error Deleting BankBalance" + msg.d.Item2);
        }

    }
    function Errordelete_BankBalance() {

        alert("Error occured in deleting. Please Contact support team");
    }


    function editBankBalance(aTag) {

        var BankBalanceid = $(aTag).data('id');
        $.ajax({
            type: "POST",
            url: "WebMethods.aspx/Edit_BankBalance",
            data: "{'id':'" + BankBalanceid + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: successedit_BankBalance,
            error: function () { alert("Error occured in editing. Please Contact support team"); }
        });

    }
    function successedit_BankBalance(data) {
        var data = data.d;
        debugger;
        if (data.length > 0) {
            $('div[id=BankBalance] div:eq(0) input[type=button]').last().click();
            $('div[id=BankBalance] div:eq(0) input[type=button][value="Update"]').data('id', data[0].BankBalance_ID);

            $('input[id$=txtBankBalanceName]').val(data[0].BankBalance_NAME);
            $('input[id$=txtBankBalanceAddress]').val(data[0].BankBalance_ADDRESS);
            $('input[id$=txtBankBalanceABN]').val(data[0].BankBalance_ABN);
            $('input[id$=txtBankBalanceContact]').val(data[0].BankBalance_CONTACT);
        }
    }

    function UpdateBankBalance() {
        var BankBalanceid = $('div[id=BankBalance] div:eq(0) input[type=button][value="Update"]').data('id');
        if (BankBalanceid != undefined) {

            var BankBalance = {};
            BankBalance.BankBalance_ID = BankBalanceid;
            BankBalance.BankBalance_NAME = $('input[id$=txtBankBalanceName]').val();
            BankBalance.BankBalance_ADDRESS = $('input[id$=txtBankBalanceAddress]').val();
            BankBalance.BankBalance_ABN = $('input[id$=txtBankBalanceABN]').val();
            BankBalance.BankBalance_CONTACT = $('input[id$=txtBankBalanceContact]').val();
            BankBalance.IS_ACTIVE = true;


            var request = JSON.stringify({ objBankBalance: BankBalance });
            $.ajax({
                type: "POST",
                url: "WebMethods.aspx/Update_BankBalance",
                data: request,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "1")
                        alert("BankBalance Updated Successfully");
                    $('div[id=BankBalance] div:eq(0) input[type=button][value="Cancel"]').click();
                    clearContentBankBalance('#BankBalance');

                },
                error: function () { alert("Error occured in Updating. Please Contact support team"); }
            });
        }
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

        $("div.toolbar").html('<b><a id="exportdatatable" onclick="ExportToExcel(\'BankBalanceReport\',$(\'#exportdatatable\').parent().parent().next().children(\'table\').html())" style="cursor:pointer;text-decoration: underline;font-style: italic;font-size: 16px;font-family: -webkit-pictograph;">Export to Excel</a></b>');
    }
    //--------------------------------- BankBalance end ---------------------------------
</script>
