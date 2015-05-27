class ex6_sequence extends uvm_sequence #(ex6_transaction);
  `uvm_object_utils(ex6_sequence)

  ex6_config _config;

  function new(string name="");
    super.new(name);
  endfunction: new

  task body();
    ex6_transaction req;

    if(!uvm_config_db #(ex6_config)::get(uvm_root::get(), "*", "ex6_config", _config))
      `uvm_fatal("SEQUENCE", "Can't read config");

    uvm_test_done.raise_objection(this);
    repeat(_config.iterations)
    begin
      req = ex6_transaction::type_id::create("req");
      start_item(req);

      if (_config.test_name == "test_zero") begin
	req.value1 = 0;
	req.value2 = 0;
	req.mode = DIV;
      end
      else if (_config.test_name == "test_lt_zero") begin
        req.value1 = 1;
	req.value2 = 2;
	req.mode = SUB;
      end
      else assert(req.randomize());

      finish_item(req);
    end
    uvm_test_done.drop_objection(this);
  endtask: body

endclass: ex6_sequence