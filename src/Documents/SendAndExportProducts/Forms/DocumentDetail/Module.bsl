
&AtClient
Procedure ProductsProductOnChange(Item)
	// Insert handler content.           
	TabularSectionRow = Items.Products.CurrentData;  
	// Thực hiện đơn vị tính
	TabularSectionRow.Unit = FillUnit(TabularSectionRow.Product);
	// Thực hiện đơn giá 
	TabularSectionRow.Price = FillPriceProduct(TabularSectionRow.Product);
	// Thực hiện số lượng còn lại trong kho
	RemainingQuantity = RemainingQuantityInWarehouse(Object.Date, Object.Warehouse,TabularSectionRow.Product);	
	If RemainingQuantity = "" Then
		 ThisObject.RemainingQuantity = 0;
	Else
		ThisObject.RemainingQuantity = RemainingQuantity;
	EndIf; 
	ThisObject.Product =  TabularSectionRow.Product;
EndProcedure

&AtServer
Function FillUnit ( CurProduct )
	Return CurProduct.Unit;
EndFunction

&AtServer
Function FillPriceProduct(CurProduct)
		Truyvan = New Query;
	
EndFunction

&AtClient
Procedure ProductsQuantityOnChange(Item)
	// Insert handler content.      
	TabularSectionRow = Items.Products.CurrentData;
	CalculateAmount(TabularSectionRow);

EndProcedure

&AtClient
Procedure ProductsPriceOnChange(Item)
	// Insert handler content.
	TabularSectionRow = Items.Products.CurrentData;
	CalculateAmount(TabularSectionRow);

EndProcedure

&AtClient
Procedure CalculateAmount(CurRow)
	CurRow.Amount = CurRow.Quantity * CurRow.Price;
	Object.Total = Object.Products.Total("Amount");
EndProcedure


&AtServer
Procedure PaymentMethodOnChangeAtServer()
	If Object.PaymentMethod = Enums.PaymentMethods.Cash Then
		 ThisObject.CommandBar.ChildItems.FormCreateBasedOn.Visible = False;
	 Else
		ThisObject.CommandBar.ChildItems.FormCreateBasedOn.Visible = True; 
	EndIf
EndProcedure


&AtClient
Procedure PaymentMethodOnChange(Item)
	PaymentMethodOnChangeAtServer();
EndProcedure

&AtServer
Function RemainingQuantityInWarehouse(Date,Warehouse,Product) 
	//{{QUERY_BUILDER_WITH_RESULT_PROCESSING
	// This fragment was built by the wizard.
	// Warning! All manually made changes will be lost next time you use the wizard.
	
	Query = New Query;
	Query.Text = 
		"SELECT
		|	InventoryBalance.Product AS Product,
		|	InventoryBalance.QuantityBalance AS QuantityBalance
		|FROM
		|	AccumulationRegister.Inventory.Balance(&Date, ) AS InventoryBalance
		|WHERE
		|	InventoryBalance.Product = &Product
		|	AND InventoryBalance.Warehouse = &Warehouse";
	
	Query.SetParameter("Product", Product);
	Query.SetParameter("Warehouse", Warehouse);  
	Query.SetParameter("Date", Date);
	
	QueryResult = Query.Execute();
	
	SelectionDetailRecords = QueryResult.Select();
	
	While SelectionDetailRecords.Next() Do
		Return SelectionDetailRecords.QuantityBalance;
	EndDo;
	
	//}}QUERY_BUILDER_WITH_RESULT_PROCESSING
	
EndFunction

&AtClient
Procedure WarehouseOnChange(Item)
	TabularSectionRow = Items.Products.CurrentData ;
   	If ValueIsFilled(Object.Products) Then
		RemainingQuantity = RemainingQuantityInWarehouse(Object.Date, Object.Warehouse,TabularSectionRow.Product);	
		If RemainingQuantity = "" Then
			 ThisObject.RemainingQuantity = 0;
		Else
			ThisObject.RemainingQuantity = RemainingQuantity;
		EndIf; 
	EndIf;
EndProcedure
