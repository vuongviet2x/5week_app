
Procedure Posting(Cancel, Mode)
	//{{__REGISTER_REGISTERRECORDS_WIZARD
	// This fragment was built by the wizard.
	// Warning! All manually made changes will be lost next time you use the wizard.

	// register Inventory Expense
	RegisterRecords.Inventory.Write = True;
	For Each CurRowProducts In Products Do
		Record = RegisterRecords.Inventory.Add();
		Record.RecordType = AccumulationRecordType.Expense;
		Record.Period = Date;
		Record.Product = CurRowProducts.Product;
		Record.Warehouse = Warehouse;
		Record.Quantity = CurRowProducts.Quantity;
	EndDo;
	
	RegisterRecords.CashFlow.Write = True;
	For Each CurRowProducts In Products Do
		Record = RegisterRecords.CashFlow.Add();
		Record.RecordType = AccumulationRecordType.Receipt;
		Record.Period = Date;
		Record.Product = CurRowProducts.Product;
		Record.Amount = CurRowProducts.Amount;
		Record.Staff = Staff;
	EndDo;

	//}}__REGISTER_REGISTERRECORDS_WIZARD
EndProcedure

Procedure Filling(FillingData, StandardProcessing)
	//{{__CREATE_BASED_ON_WIZARD
	// This fragment was built by the wizard.
	// Warning! All manually made changes will be lost next time you use the wizard.
	If TypeOf(FillingData) = Type("DocumentRef.PriceQuote") Then
		// Filling the headline
		Customer = FillingData.Customer;
		Staff = FillingData.Staff;
		For Each CurRowProducts In FillingData.Products Do
			NewRow = Products.Add();
			NewRow.Price = CurRowProducts.Price;
			NewRow.Product = CurRowProducts.Product;
			NewRow.Unit = CurRowProducts.Unit;
		EndDo;
	EndIf;
	//}}__CREATE_BASED_ON_WIZARD
EndProcedure
