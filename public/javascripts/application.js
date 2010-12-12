
var TextAreaResize = Class.create();
TextAreaResize.prototype = {
  initialize: function( element, options ) {
    element = $( element );
    this.element = element;

    this.options = Object.extend(
      {},
      options || {} );

    Event.observe( this.element, 'keyup',
      this.onKeyUp.bindAsEventListener( this ) );
    this.onKeyUp();
    element.style.height = 'auto';
  },

  onKeyUp: function() {
    // We need this variable because "this" changes in the scope of the
    // function below.
    var cols = this.element.cols;

    var linecount = 0;
    $A( this.element.value.split( "\n" ) ).each( function( l ) {
      // We take long lines into account via the cols divide.
      linecount += 1 + Math.floor( l.length / cols );
    } )

    this.element.rows = linecount;
  }
}

Array.prototype.sum = function(){
	for(var i=0,sum=0;i<this.length;i++){
  	if(this[i]!='') sum+=parseFloat(this[i]);
	}
	return sum;
}

/*update_invoice_product*/
function uip(id){
  tr = $(id).up('.association-record');
  q = tr.down('.quantity-input');
  p = tr.down('.price-input');
  t = tr.down('.total-input');
  t.value = (p.value*q.value).toFixed(2);
  uit($(id).up('form'));
}

/*update_invoice_totals*/
function uit(f){
  st =f.getElementsBySelector('.total-input').pluck('value').sum();
  d10 = f.down('.has_descuento_10-input').checked?-st*0.1:0;
  st1 = st + d10
  d20 = f.down('.has_descuento_20-input').checked?-st1*0.2:0;
  st2 = st1 + d20
  iva = st2 * f.down('.iva_percent-input').value/100;
  tot = st2 + iva
  t = f.down('table.totals');
  t.down('.subtotal').update(st.toFixed(2));
  t.down('.descuento_10').update(d10.toFixed(2));
  t.down('.subtotal1').update(st1.toFixed(2));
  t.down('.descuento_20').update(d20.toFixed(2));
  t.down('.subtotal2').update(st2.toFixed(2));
  t.down('.iva').update(iva.toFixed(2));
  t.down('.total').update(tot.toFixed(2));
}

/*update_column_complete*/
function ucc(f_id, scope){
  if(scope){
    p = document.getElementsByName('record'+scope+'[product]')[0].id;
    uip(p);
  }else{
    uit($(f_id));
  }
}


function validateNumeric(e,i)
{
  e = e || window.event;
  var key = e.which || e.keyCode;
  if (key == 190 && !i){
    return (e.currentTarget.value.indexOf('.')==-1);
  }else if(key == 188){
    return false;
  }else{
    return (
        key == 8 || 
        key == 9 ||
        key == 46 ||
        (key >= 37 && key <= 40) ||
        (key >= 48 && key <= 57) ||
        (key >= 96 && key <= 105));
  }

}




