function ValidaDocs(doc) {

	doc = doc.toString();

	doc = doc.replace(/[^0-9]/g, '');

	var primeiro = doc.substring(0, 1);
	var replace = new RegExp(primeiro,'g');
	
	var doc_igual = doc.replace(replace,'');

	if (doc_igual != '') {
		if (doc.length == 11) {
			if (ValidaCPF(doc))
				return true;
		} else {
			if (doc.length == 14) {
				if (ValidaCNPJ(doc))
					return true;
			} else {
				return false;
			}
		}
	}
	else
		return false;
}

function ValidaCPF(doc) {
	var digitoDigitado = eval(doc.charAt(9) + doc.charAt(10));
	var soma1 = 0, soma2 = 0;
	var vlr = 11;

	for (var i = 0; i < 9; i++) {
		soma1 += eval(doc.charAt(i) * (vlr - 1));
		soma2 += eval(doc.charAt(i) * vlr);
		vlr--;
	}

	
	soma1 = (((soma1 * 10) % 11) == 10 ? 0 : ((soma1 * 10) % 11));
	

	soma2 += soma1 * 2;
	soma2 = (((soma2 * 10) % 11) == 10 ? 0 : ((soma2 * 10) % 11));

	var digitoGerado = (soma1 * 10) + soma2;

	if (digitoGerado != digitoDigitado) {
		return false;
	} else {
		return true;
	}
}

function ValidaCNPJ(doc) {
	var valida = new Array(6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2);
	var dig1 = new Number;
	var dig2 = new Number;
	var digito = new Number(eval(doc.charAt(12) + doc.charAt(13)));

	for (var i = 0; i < valida.length; i++) {
		dig1 += (i > 0 ? (doc.charAt(i - 1) * valida[i]) : 0);
		dig2 += doc.charAt(i) * valida[i];
	}
	dig1 = (((dig1 % 11) < 2) ? 0 : (11 - (dig1 % 11)));
	dig2 = (((dig2 % 11) < 2) ? 0 : (11 - (dig2 % 11)));

	if (((dig1 * 10) + dig2) != digito) {
		return false;
	} else {
		return true;
	}
}