class ex5_transaction extends uvm_sequence_item;
  //declarations
  //rand logic data[7:0];
  rand logic data[7:0];

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
     $sformat(s, "%s data[%0d] \t%0h\n", s, i, data[i]);
   end
   return s;
  endfunction: convert2string

endclass: ex5_transaction