<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PurchaseControl.ascx.cs" Inherits="Admin_AdminControls_Purchase" %>

<div id="Purchases" class="innerContainer container">
    <div class="lead" data-name="buttonsDiv-Purchases" style="width: 100%; height: 60px;">
        <input class="btn" type="button" title="Add Purchase" value="Add Purchase" onclick="AddPurchase()" />
        <input class="btn" type="button" title="Clear Fields" value="Clear Fields" onclick="clearContentPurchases('#Purchases')" />
        <input class="btn" type="button" title="Back" value="Back" style="display: none" onclick="manageSection('Add Purchase,Clear Fields,Show Purchases', 'Purchases-Add', 'content-Purchases', this);" />
        <input class="btn" type="button" title="ShowPurchases" value="Show Purchases" onclick="manageSection('Show Purchases,Back', 'Purchases-Show', 'content-Purchases', this); ShowPurchases()" />
        <input class="btn" type="button" value="Update" style="display: none" onclick="UpdatePurchase(); " />
        <input class="btn" type="button" value="Cancel" style="display: none" onclick="manageSection('Add Purchase,Clear Fields,Show Purchases', 'Purchases-Add', 'content-Purchases', this); clearContentPurchases('#Purchases');" />
        <input class="btn" type="button" value="Edit" style="display: none" onclick="manageSection('Update,Cancel', 'Purchases-Add', 'content-Purchases', this);" />
        <hr style="margin-top: 10px; margin-bottom: 20px; float: left; width: 100%" />
    </div>
    <div id="content-Purchases">
        <div id="Purchases-Add">

            <div class="row">

                <div class="panel panel-default col-md-5" style="height: 450px;">
                    <div class="panel-heading">
                        <h3 class="panel-title">Slip</h3>
                    </div>
                    <div class="panel-body">

                        <div class="form-group">

                            <label>Account</label>
                            <div id="divAccount" runat="server">
                            <select class="form-control" id="txtAccount" onchange="setAccountChange()">                             
                                <option class="form-control" selected="selected" value="1">HT</option>                             
                            </select>
                                </div>
                        </div>
                        <div class="form-group">
                            <label>Previous Balance</label>
                            <input type="text" class="form-control" id="txtPreviousBalance" disabled="disabled" placeholder="">
                        </div>
                        <div class="form-group">
                            <label>Amount(Slip)</label>
                            <input type="number" class="form-control"  id="txtAmountSlip" placeholder="">
                        </div>
                        <div class="form-group">
                            <label>Slip Date</label>
                            <input type="text" class="form-control" id="txtSlipDate" placeholder="">
                        </div>
                        <div class="form-group">
                            <label>Slip Code</label>
                            <input type="text" class="form-control" id="txtSlipCode" placeholder="">
                        </div>
                        <br />
                    </div>


                </div>

                <div class="col-md-5">

                    <div class="panel panel-default" style="height: 450px; margin-left: 20px;">

                        <div class="panel-heading">
                            <h3 class="panel-title" style="width: 30px; display: inline;">Stock</h3>
                            <span style="width: 250px; display: inline-block; text-align: right;">
                                <label>Purchase Date</label>
                                <input type="text" id="txtPurchaseDate" placeholder="" style="width: 100px;">
                            </span>
                        </div>
                        <div class="panel-body">

                            <div class="form-group">
                                <label>Quantity(Bags)</label>
                                <input type="number" class="form-control" id="txtQuantity" placeholder="" onblur="setUnitPrice()">
                            </div>
                            <div class="form-group">
                                <label>Stock Amount</label>
                                <input type="number" class="form-control" id="txtStockAmount" placeholder="" onblur="setUnitPrice()">
                            </div>
                            <div class="form-group">
                                <label>Unit Price</label>
                                <input type="number" class="form-control" id="txtUnitPrice" placeholder="">
                            </div>
                            <div class="form-group">
                                <label>Vehicle Number</label>
                                <input  class="form-control" id="txtVehicle" placeholder="">
                             
                            </div>
                            <div class="form-group">
                                <div style="clear: both; text-align: right"></div>
                                <div style="">
                                </div>
                                <input class="btn" type="button" value="Save" onclick="AddPurchase();" />
                            </div>
                            <br />
                        </div>

                    </div>
                </div>


            </div>

        </div>

 

    <div id="Purchases-Show" style="display: none;">
        Active
    </div>
       </div>
</div>

<script>

    //--------------------------------- Purchases ---------------------------------

    $(document).ready(function () {
       // setAccountChange();
        $("#txtSlipDate").datepicker({
            changeMonth: true,
            changeYear: true
        });

        $("#txtSlipDate").datepicker("setDate", new Date());

        $("#txtPurchaseDate").datepicker({
            changeMonth: true,
            changeYear: true
        });

        $("#txtPurchaseDate").datepicker("setDate", new Date());
    });
    function setAccountChange()
    {
        var bal = $('#txtAccount option:selected').attr('name');
        $('#txtPreviousBalance').val(bal);
        

    }
    function setUnitPrice()
    {
        var quantity = $('#txtQuantity').val();
        var amount = $('#txtStockAmount').val();
        if ((quantity != "" || quantity > 0) && (amount != "" && amount > 0))
        {
            $('#txtUnitPrice').val(amount/quantity);
        }
    }
   
    function AddPurchase() {

        var Purchase = {};
        Purchase.ACC_ID = $('select[id$=txtAccount] option:selected').val();;
        Purchase.SLIP_AMOUNT = $('input[id$=txtAmountSlip]').val();
        Purchase.SLIP_DATE = $('input[id$=txtSlipDate]').val();
        Purchase.SLIP_CODE = $('input[id$=txtSlipCode]').val();
        Purchase.PURCHASE_QUANTITY = $('input[id$=txtQuantity]').val();
        Purchase.PURCHASE_AMOUNT = $('input[id$=txtStockAmount]').val();
        Purchase.PURCHASE_UNIT_PRICE = $('input[id$=txtUnitPrice]').val();
        Purchase.PURCHASE_VEHICLE_NUMBER = $('input[id$=txtVehicle]').val(); //$('select[id$=txtVehicle] option:selected').val();
        Purchase.PURCHASE_DATE = $('input[id$=txtPurchaseDate]').val();


        $.ajax({
            type: "POST",
            url: "WebMethods.aspx/AddPurchase",
            data: JSON.stringify({ objPurchase: Purchase }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {

                if (msg.d.Item1 == 0) {
                    alert("Purchase Saved Successfully");
                    clearContent('#Purchases');
                }
                else
                    alert("Error Saving Purchase:" + msg.Item2);              

            },
            error: ErrorAddPurchase
        });
    }

    function clearContent(div) {
        var ref_id = div + ' input[type="text"]:visible, textarea:visible, input[type="file"]:visible'
        $(ref_id).val('');
        setAccountChange();
    }
    function clearContentPurchases(div) {
        var ref_id = div + ' input[type="text"]:visible, textarea:visible, input[type="file"]:visible'
        $(ref_id).val('');
        setAccountChange();

    }
    function ErrorAddPurchase() {
        alert("Some Error occured in adding Purchase. Please contact Support team");
    }
    function ShowPurchases() {

        $.ajax({
            type: "POST",
            url: "WebMethods.aspx/ShowPurchases",
            data: "{}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: successShowPurchases,
            error: ErrorShowPurchases
        });
    }

    function successShowPurchases(data) {

        $('#Purchases-Show').html(generateTable(data.d));
        SetDataTable('#tblDatatable');
    }
    function generateTable(data) {     
    
        var table = "<div class='toolbar'></div>";
        table +="<table id='tblDatatable' cellspacing ='1px' style='width:100%'>";
        table += "<thead><tr>";

        table += "<th style='width:50px'>Sr.</th>";
        table += "<th>Account Name</th>";
        table += "<th>Detail Date</th>";
        table += "<th>Slip Amount</th>";
        table += "<th>Stock Amount</th>";
        table += "<th>Quantity</th>";
        table += "<th>Total Balance</th>";
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
            table += "<td>" + data[i].SLIPAMOUNT + "</td>";
            table += "<td>" + data[i].STOCKAMOUNT + "</td>";
            table += "<td>" + data[i].QUANTITY + "</td>";
            table += "<td>" + data[i].ACC_TOTAL_BAL + "</td>";
            
            if (i == 0) {
                table += "<td><a style='cursor:pointer;color:red' data-id='" + data[i].PURCHASE_ID + "' onclick='deletePurchase(this)'>Delete</a></td>";
            }
            else {
                if (jQuery.inArray(data[i].ACC_NAME, uniqueAccounts) == -1)
                    table += "<td><a style='cursor:pointer;color:red' data-id='" + data[i].PURCHASE_ID + "' onclick='deletePurchase(this)'>Delete</a></td>";
                else
                table += "<td id='" + data[i].PURCHASE_ID + "'></td>";
            }

            if (jQuery.inArray(data[i].ACC_NAME, uniqueAccounts) == -1) {
                uniqueAccounts.push(data[i].ACC_NAME);
            }
            
            table += "</tr>";
        }       
        table + "</tbody>";
        table += "</table>";
        return table;

    }
    function ErrorShowPurchases() {

        alert("Some Error occured in showing Purchase. Please contact Support team");

    }

    function deletePurchase(aTag) {

        var Purchaseid = $(aTag).data('id');
        $.ajax({
            type: "POST",
            url: "WebMethods.aspx/DeletePurchase",
            data: "{'id':'" + Purchaseid + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: successdelete_Purchases,
            error: Errordelete_Purchases
        });

    }
    function successdelete_Purchases(msg) {

        if (msg.d.Item1 == 0) {
            alert("Deleted successfully");
            ShowPurchases();
        }
        else {
            alert("Error in Deleting: " + msg.d.Item2);
            ShowPurchases();
        }
       
    }
    function Errordelete_Purchases() {

        alert("Error occured in deleting. Please Contact support team");
    }


    function editPurchase(aTag) {

        var Purchaseid = $(aTag).data('id');
        $.ajax({
            type: "POST",
            url: "WebMethods.aspx/Edit_Purchase",
            data: "{'id':'" + Purchaseid + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: successedit_Purchases,
            error: function () { alert("Error occured in editing. Please Contact support team"); }
        });

    }
    function successedit_Purchases(data) {
        var data = data.d;
        debugger;
        if (data.length > 0) {
            $('div[id=Purchase] div:eq(0) input[type=button]').last().click();
            $('div[id=Purchase] div:eq(0) input[type=button][value="Update"]').data('id', data[0].Purchase_ID);

            $('input[id$=txtPurchaseName]').val(data[0].Purchase_NAME);
            $('input[id$=txtPurchaseAddress]').val(data[0].Purchase_ADDRESS);
            $('input[id$=txtPurchaseABN]').val(data[0].Purchase_ABN);
            $('input[id$=txtPurchaseContact]').val(data[0].Purchase_CONTACT);
        }
    }

    function UpdatePurchase() {
        var Purchaseid = $('div[id=Purchase] div:eq(0) input[type=button][value="Update"]').data('id');
        if (Purchaseid != undefined) {

            var Purchase = {};
            Purchase.Purchase_ID = Purchaseid;
            Purchase.Purchase_NAME = $('input[id$=txtPurchaseName]').val();
            Purchase.Purchase_ADDRESS = $('input[id$=txtPurchaseAddress]').val();
            Purchase.Purchase_ABN = $('input[id$=txtPurchaseABN]').val();
            Purchase.Purchase_CONTACT = $('input[id$=txtPurchaseContact]').val();
            Purchase.IS_ACTIVE = true;


            var request = JSON.stringify({ objPurchase: Purchase });
            $.ajax({
                type: "POST",
                url: "WebMethods.aspx/Update_Purchase",
                data: request,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "1")
                        alert("Purchase Updated Successfully");
                    $('div[id=Purchase] div:eq(0) input[type=button][value="Cancel"]').click();
                    clearContentPurchases('#Purchase');

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
            "aoColumns": columns,
            "dom": '<"toolbar">frtip'
        });

       

        $("div.toolbar").html('<b><a id="exportdatatable" onclick="ExportToExcel(\'StockReport\',$(\'#exportdatatable\').parent().parent().next().children(\'table\').html())" style="cursor:pointer;text-decoration: underline;font-style: italic;font-size: 16px;font-family: -webkit-pictograph;">Export to Excel</a></b>');
        //table selection 
        //
    }
    //--------------------------------- Purchases end ---------------------------------
</script>
