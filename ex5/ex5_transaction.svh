class ex5_transaction extends uvm_sequence_item;
  //declarations
  rand logic data[7:0];
  logic result[7:0];

  //declaration macros
  `uvm_object_utils_begin(ex5_transaction)
    // How do we use these macros?
    // `uvm_field_int(data, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(logic idata[7:0] = { 0, 0, 0, 0, 0, 0, 0, 0 });
    super.new();
    data = idata;
  endfunction: new

  //convert2string
  function string convert2string();
   string s;

   s = super.convert2string();
   // For an array we need to iterate through the values:
   foreach(data[i]) begin
     $sformat(s, "%s data[%0d] \t%0h result[%0d] \t%0h\n", s, i, data[i], i, result[i]);
   end
   return s;
  endfunction: convert2string

  function string output2string();
    string s;
    s = $sformat("result=%4h", result);
    return s;
  endfunction

  function uvm_object clone();
    ex5_transaction tmp = new this;
    return(tmp);
  endfunction

  function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    ex5_transaction tmp;
    $cast(tmp, rhs); // cast so can access the fields
    return (data   == tmp.data &&
           result == tmp.result);
  endfunction

  function void do_copy(uvm_object rhs);
    ex5_transaction tmp;
    if(!$cast(tmp, rhs)) // cast so can access the fields
      uvm_report_fatal("TypeMismatch", "Type mismatch in copy");
    super.do_copy(tmp);
    data   = tmp.data;
    result = tmp.result;
  endfunction
endclass: ex5_transaction