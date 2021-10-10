<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SaleControl.ascx.cs" Inherits="Admin_AdminControls_Sale" %>


<div id="Sales" class="innerContainer container">
    <div class="lead" data-name="buttonsDiv-Sales" style="width: 100%; height: 60px;">
        <input class="btn" type="button" title="Add Sale" value="Add Sale" onclick="AddSale()" />
        <input class="btn" type="button" title="Clear Fields" value="Clear Fields" onclick="clearContentSales('#Sales')" />
        <input class="btn" type="button" title="Back" value="Back" style="display: none" onclick="manageSection('Add Sale,Clear Fields,Show Sales', 'Sales-Add', 'content-Sales', this);" />
        <input class="btn" type="button" title="ShowSales" value="Show Sales" onclick="manageSection('Show Sales,Back', 'Sales-Show', 'content-Sales', this); ShowSales()" />
        <input class="btn" type="button" value="Update" style="display: none" onclick="UpdateSale(); " />
        <input class="btn" type="button" value="Cancel" style="display: none" onclick="manageSection('Add Sale,Clear Fields,Show Sales', 'Sales-Add', 'content-Sales', this); clearContentSales('#Sales');" />
        <input class="btn" type="button" value="Edit" style="display: none" onclick="manageSection('Update,Cancel', 'Sales-Add', 'content-Sales', this);" />
        <hr style="margin-top: 10px; margin-bottom: 20px; float: left; width: 100%" />
    </div>
    <div id="content-Sales">
        <div id="Sales-Add">

            <div class="form-inline clearfix">

                <div class="form-group col-md-3">
                    <label class="">Vehicle(Date)</label>
                    <div id="divAccount" runat="server">
                        <select class="form-control" id="ddlActivePurchase" onchange="setActivePurchase()">
                          
                        </select>
                    </div>
                </div>
                <div class="col-md-1"></div>
                <div class="form-group col-md-3">
                    <label class="">Sale Date</label>
                    <input type="text" class="form-control col-md-2" id="txtSaleDate" placeholder="">
                </div>
                
            </div>
            <div class="form-inline  clearfix" style="margin-top:15px;">
                <div class="form-group col-md-3">
                    <label>Account</label>
                    <select class="form-control" id="ddlAccount" onchange="setAccountBalance()">
                       <%-- <option class="form-control" selected="selected" value="1">Dealer 1</option>--%>
                    </select>
                </div>             
            </div>
            <hr />
            <div class="form-inline  clearfix" style="margin-bottom: 15px;">
                <div class="form-group col-md-3">
                    <span>
                        <label>Sale Quantity</label>
                        <input type="text" class="form-control" id="txtSaleQuantity" placeholder="" onchange="setTotalAmount()">
                    </span>
                </div>
                <div class="col-md-1"></div>
                <div class="form-group  col-md-3">
                    <label for="txtUnitPrice">Unit Price</label>
                    <input type="text" class="form-control" id="txtUnitPrice" placeholder="" onchange="setTotalAmount()">
                </div>
                <div class="col-md-1"></div>
                <div class="form-group  col-md-3">
                    <label>Total Amount</label>
                    <input type="text" class="form-control" id="txtTotalAmount" disabled="disabled" placeholder="">
                </div>
            </div>
                <div class="form-inline  clearfix" style="margin-top: 15px;">
                <div class="form-group  col-md-3">
                    <label class="control-label">Received Amount</label>
                    <input type="text" class="form-control" id="txtReceivedAmount" placeholder="" onchange="setRemainingBalance()">
                </div>
               
            </div>
            <div class="form-inline  clearfix" style="margin-top: 15px;">
                <div class="form-group  col-md-3">
                    <label class="control-label">Previous Balance</label>
                    <input type="text" class="form-control" id="txtPreviousBalance" disabled="disabled" placeholder="">
                </div>
                <div class="col-md-1"></div>
                <div class="form-group  col-md-3">
                    <label>Remaining Amount</label>
                    <input type="text" class="form-control" id="txtRemainingAmount" disabled="disabled" placeholder="">
                </div>
            </div>
            <br />

        </div>



        <div id="Sales-Show" style="display: none;">
            Active
        </div>
    </div>
</div>

<script>

    //--------------------------------- Sales ---------------------------------

    $(document).ready(function () {
        //setAccountChange();
        $("#txtSaleDate").datepicker({
            changeMonth: true,
            changeYear: true
        });

        $("#txtSaleDate").datepicker("setDate", new Date());
       
    });
    function setActivePurchase() {
        // var bal = $('#txtAccount option:selected').attr('name');
        // $('#txtPreviousBalance').val(bal);


    }
    function setTotalAmount() {
        var quantity = $('#txtSaleQuantity').val();
        var unitPrice = $('#txtUnitPrice').val();
        if ((quantity != "" || quantity >= 0) && (unitPrice != "" && unitPrice >= 0)) {
            $('#txtTotalAmount').val(quantity * unitPrice);
        }
        setRemainingBalance();
    }
    function setAccountBalance()
    {
        var accountBalance = $('#ddlAccount option:selected').data('bal');
        
        if ((accountBalance != "" || accountBalance >= 0)) {
            
            $('#txtPreviousBalance').val(accountBalance);
        }
    }
    function setRemainingBalance()
    {
        var accountBalance = $('#ddlAccount option:selected').data('bal');
        var totalAmount = $('#txtTotalAmount').val() == "" ? 0 : $('#txtTotalAmount').val();
        var receiving = $('#txtReceivedAmount').val() == "" ? 0 : $('#txtReceivedAmount').val();
        var result = parseInt((parseInt(accountBalance) + parseInt(totalAmount)) - receiving);
        $('#txtRemainingAmount').val(result);
    }
    function LoadActivePurchases()
    {
        $.ajax({
            type: "POST",
            url: "WebMethods.aspx/LoadActivePurchases",
            data: "",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
                if (msg.d.Item2 == 0) {
                
                    var data = msg.d.Item1;
                    
                    var html = '';
                        //html = '<select class="form-control" id="ddlActivePurchase" onchange="setActivePurchase()">';
                    for (var i = 0; i < data.length; i++) {
                        if (i == 0) {
                            html += '<option class="form-control" selected="selected" value="' + data[i].PURCHASE_ID + '">' + data[i].PURCHASING_VEHICLE + '</option>';
                        }
                        else
                        {
                            html += '<option class="form-control" value="' + data[i].PURCHASE_ID + '">' + data[i].PURCHASING_VEHICLE + '</option>';
                        }
                    }
                   // html += '</select>';
                    $('#ddlActivePurchase').html(html);
                        
                }
                else
                    alert("Error Loading Active Purchases: " + msg.d.Item3);

            },
            error: ErrorLoadActivePurchase
        });
    }
    function LoadDealerAccounts()
    {
        $.ajax({
            type: "POST",
            url: "WebMethods.aspx/LoadDealerAccounts",
            data: "",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
                if (msg.d.Item2 == 0) {

                    var data = msg.d.Item1;
                    
                    var html = '';
                   
                    for (var i = 0; i < data.length; i++) {
                        if (i == 0) {
                            html += '<option class="form-control" selected="selected" data-bal="' + data[i].ACC_CURR_BAL + '" value="' + data[i].ACC_ID + '">' + data[i].ACC_NAME + '</option>';
                        }
                    else
                    {
                            html += '<option class="form-control" data-bal="' + data[i].ACC_CURR_BAL + '" value="' + data[i].ACC_ID + '">' + data[i].ACC_NAME + '</option>';
                        }
                    }
                   
                    $('#ddlAccount').html(html);
                    setAccountBalance();
                }
                else
                    alert("Error Loading Dealer Accounts: " + msg.d.Item3);

            },
            error: ErrorLoadActivePurchase
        });
    }
    function AddSale() {

        var Sale = {};
        Sale.ACC_ID = $('select[id$=ddlAccount] option:selected').val();
        Sale.DEALER_TRANS_ID = 0;
        Sale.PURCHASE_ID = $('select[id$=ddlActivePurchase] option:selected').val();; //$('input[id$=txtSlipDate]').val();
        Sale.TRANS_DATE = $('input[id$=txtSaleDate]').val();
        Sale.SALE_QUANTITY = $('input[id$=txtSaleQuantity]').val();
        Sale.SALE_AMOUNT = $('input[id$=txtTotalAmount]').val();
        Sale.SALE_UNIT_PRICE = $('input[id$=txtUnitPrice]').val();
        Sale.RECEIVED_AMOUNT = $('input[id$=txtReceivedAmount]').val(); 
        Sale.IS_DELETE = false;


        $.ajax({
            type: "POST",
            url: "WebMethods.aspx/AddSale",
            data: JSON.stringify({ objSale: Sale }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
                if (msg.d.Item1 == 0) {
                    alert("Sale Saved Successfully");
                    clearContent('#Sales');
                }
                else
                    alert("Error Saving Sale:" + msg.Item2);

            },
            error: ErrorAddSale
        });
    }

    function clearContent(div) {
        var ref_id = div + ' input[type="text"]:visible, textarea:visible, input[type="file"]:visible'
        $(ref_id).val('');
        setAccountChange();
    }
    function clearContentSales(div) {
        var ref_id = div + ' input[type="text"]:visible, textarea:visible, input[type="file"]:visible'
        $(ref_id).val('');
        setAccountChange();

    }
    function ErrorAddSale() {
        alert("Some Error occured in adding Sale. Please contact Support team");
    }
    function ErrorLoadActivePurchase()
    {
        alert("Some Error occured in loading active purchase. Please contact Support team");
    }
    function ShowSales() {

        $.ajax({
            type: "POST",
            url: "WebMethods.aspx/ShowSales",
            data: "{}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: successShowSales,
            error: ErrorShowSales
        });
    }

    function successShowSales(data) {

        $('#Sales-Show').html(generateTable(data.d.Item3));
        SetDataTable('#tblDatatable');
    }
    function generateTable(data) {

        var table = "<div class='toolbar'></div>";
        table += "<table id='tblDatatable' cellspacing ='1px' style='width:100%'>";
        table += "<thead><tr>";

        table += "<th style='width:50px'>Sr.</th>";
        table += "<th>Account Name</th>";
        table += "<th>Detail Date</th>";
        table += "<th>Previous Balance</th>";
        table += "<th>Delivered</th>";
        table += "<th>Total Balance</th>";
        table += "<th>Receiving</th>";
        table += "<th>Remaining Balance</th>";
        table += "<th>Delete</th>";

        table += "</tr></thead><tbody>";

        var serial = 0;
        var uniqueAccounts = [];
        for (var i = 0; i < data.length; i++) {
            serial++;
            table += "<tr>";

            table += "<td>" + serial + "</td>";
            table += "<td>" + data[i].ACC_NAME + "</td>";
            table += "<td>" + msToTime(data[i].DETAIL_DATE) + "</td>";
            table += "<td>" + data[i].ACC_PREV_BAL + "</td>";
            table += "<td>" + data[i].DELIVERED + "</td>";
            table += "<td>" + data[i].TOTALBALANCE + "</td>";
            table += "<td>" + data[i].RECEIVING + "</td>";
            table += "<td>" + data[i].REMAINING_BALANCE + "</td>";
            
            //if (i == 0)
            //{
            
            //    table += "<td><a style='cursor:pointer;color:red' data-id='" + data[i].TRANSACTION_ID + "' onclick='deleteSale(this)'>Delete</a></td>";
            //}
            //else
            //{
            //    table += "<td id='" + data[i].TRANSACTION_ID + "'></td>";
            //}
            
            if (jQuery.inArray(data[i].ACC_NAME, uniqueAccounts) == -1)
                {
                    table += "<td><a style='cursor:pointer;color:red' data-id='" + data[i].TRANSACTION_ID + "' onclick='deleteSale(this)'>Delete</a></td>";
            }
            else {
                table += "<td id='" + data[i].TRANSACTION_ID + "'></td>";
            }
            
            table += "</tr>";

            if (jQuery.inArray(data[i].ACC_NAME, uniqueAccounts) == -1) {
                uniqueAccounts.push(data[i].ACC_NAME);
            }
        }
        table + "</tbody>";
        table += "</table>";
        return table;

    }
    function ErrorShowSales() {

        alert("Some Error occured in showing Sale. Please contact Support team");

    }

    function deleteSale(aTag) {

        var Saleid = $(aTag).data('id');
        $.ajax({
            type: "POST",
            url: "WebMethods.aspx/DeleteSale",
            data: "{'id':'" + Saleid + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: successdelete_Sales,
            error: Errordelete_Sales
        });

    }
    function successdelete_Sales(msg) {
        if (msg.d.Item1 == 0) {
            alert("Deleted successfully");
            ShowSales();
        }
        else
        {
            alert("Error in Deleting: " + msg.d.Item2);
            ShowSales();
        }
    }
    function Errordelete_Sales() {

        alert("Error occured in deleting. Please Contact support team");
    }


    function editSale(aTag) {

        var Saleid = $(aTag).data('id');
        $.ajax({
            type: "POST",
            url: "WebMethods.aspx/Edit_Sale",
            data: "{'id':'" + Saleid + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: successedit_Sales,
            error: function () { alert("Error occured in editing. Please Contact support team"); }
        });

    }
    function successedit_Sales(data) {
        var data = data.d;
        debugger;
        if (data.length > 0) {
            $('div[id=Sale] div:eq(0) input[type=button]').last().click();
            $('div[id=Sale] div:eq(0) input[type=button][value="Update"]').data('id', data[0].Sale_ID);

            $('input[id$=txtSaleName]').val(data[0].Sale_NAME);
            $('input[id$=txtSaleAddress]').val(data[0].Sale_ADDRESS);
            $('input[id$=txtSaleABN]').val(data[0].Sale_ABN);
            $('input[id$=txtSaleContact]').val(data[0].Sale_CONTACT);
        }
    }

    function UpdateSale() {
        var Saleid = $('div[id=Sale] div:eq(0) input[type=button][value="Update"]').data('id');
        if (Saleid != undefined) {

            var Sale = {};
            Sale.Sale_ID = Saleid;
            Sale.Sale_NAME = $('input[id$=txtSaleName]').val();
            Sale.Sale_ADDRESS = $('input[id$=txtSaleAddress]').val();
            Sale.Sale_ABN = $('input[id$=txtSaleABN]').val();
            Sale.Sale_CONTACT = $('input[id$=txtSaleContact]').val();
            Sale.IS_ACTIVE = true;


            var request = JSON.stringify({ objSale: Sale });
            $.ajax({
                type: "POST",
                url: "WebMethods.aspx/Update_Sale",
                data: request,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "1")
                        alert("Sale Updated Successfully");
                    $('div[id=Sale] div:eq(0) input[type=button][value="Cancel"]').click();
                    clearContentSales('#Sale');

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

        $("div.toolbar").html('<b><a id="exportdatatable" onclick="ExportToExcel(\'SaleReport\',$(\'#exportdatatable\').parent().parent().next().children(\'table\').html())" style="cursor:pointer;text-decoration: underline;font-style: italic;font-size: 16px;font-family: -webkit-pictograph;">Export to Excel</a></b>');
    }
    //--------------------------------- Sales end ---------------------------------
</script>
