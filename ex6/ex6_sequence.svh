class ex6_sequence extends uvm_sequence #(ex6_transaction);
  `uvm_object_utils(ex6_sequence)

  function new(string name="");
    super.new(name);
  endfunction: new

  task body();
    ex6_transaction req;
    //prevents the test from finishing while the sequence is in progress
    uvm_test_done.raise_objection(this);
    repeat(10)
    begin
      req = ex6_transaction::type_id::create("req");
      start_item(req);
      assert(req.randomize());
      finish_item(req);
    end
    uvm_test_done.drop_objection(this);
  endtask: body

endclass: ex6_sequence