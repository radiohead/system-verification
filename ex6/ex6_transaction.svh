class ex6_transaction extends uvm_sequence_item;
  //declarations
  rand shortint unsigned value1;
  rand shortint unsigned value2;
  rand op_type mode;

  constraint value1_range {
    value1 < 100;
    value1 >= 0;
  }

  constraint value2_range {
    value2 < 100;
    value2 >= 0;
  }

  shortint unsigned result;
  int correct;

  ///declaration macros
  `uvm_object_utils_begin(ex6_transaction)
    `uvm_field_int(value1, UVM_ALL_ON)
    `uvm_field_int(value2, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(int _value1 = 0, int _value2 = 0, op_type _mode = ADD);
    super.new();
    value1 = _value1;
    value2 = _value2;
    mode = _mode;
  endfunction: new

  //convert2string
  function string convert2string();
   string s;

   s = super.convert2string();
   $sformat(s, "%s value1 \t%0h\n", s, value1);
   $sformat(s, "%s value2 \t%0h\n", s, value2);
   $sformat(s, "%s result \t%0h\n", s, result);
   $sformat(s, "%s correct \t%0h\n", s, correct);
   return s;
  endfunction: convert2string

  function string output2string();
    string s;
    s = $sformatf("result=%p", result);
    return s;
  endfunction

  function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    ex6_transaction tmp;
    $cast(tmp, rhs); // cast so can access the fields
    return (value1   == tmp.value1 &&
            value2   == tmp.value2 &&
            mode     == tmp.mode &&
            result   == tmp.result &&
            correct  == tmp.correct);
  endfunction

  function void do_copy(uvm_object rhs);
    ex6_transaction tmp;
    if(!$cast(tmp, rhs)) // cast so can access the fields
      uvm_report_fatal("TypeMismatch", "Type mismatch in copy");
    super.do_copy(tmp);
    value1   = tmp.value1;
    value2   = tmp.value2;
    mode     = tmp.mode;
    result   = tmp.result;
    correct  = tmp.correct;
  endfunction
endclass: ex6_transaction