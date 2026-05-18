
Procedure Filling(FillingData, StandardProcessing)
	//{{__CREATE_BASED_ON_WIZARD
	// This fragment was built by the wizard.
	// Warning! All manually made changes will be lost next time you use the wizard.
	If TypeOf(FillingData) = Type("DocumentRef.ReceiveAndImportProducts") Then
		// Filling the headline
		Counterparty = FillingData.Counterparty;
		Memo = FillingData.Ref;
		Amount = FillingData.Total;
	EndIf;
	//}}__CREATE_BASED_ON_WIZARD
EndProcedure
