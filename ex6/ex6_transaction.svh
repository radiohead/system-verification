class ex6_transaction extends uvm_sequence_item;
  //declarations
  rand int value1;
  rand int value2;
  typedef enum {ADD, SUB, MUL, DIV} op_type;
  rand op_type mode;

  //declaration macros
  `uvm_object_utils_begin(ex6_transaction)
    // How do we use these macros?
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
   return s;
  endfunction: convert2string

endclass: ex6_transaction