function validMobile(value){
	return /^(13|15|18)\d{9}$/i.test(value);
}

function validDouble(value){
	return /^\d+(\.\d+)?$/i.test(value);
}

function validInteger(value){
	return /^[+]?[1-9]+\d*$/i.test(value);
}