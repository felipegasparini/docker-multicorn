create extension multicorn;

CREATE SERVER multicorn_imap FOREIGN DATA WRAPPER multicorn
options (
  wrapper 'sample.constant_foreign_data_wrapper.ConstantForeignDataWrapper'
);

CREATE FOREIGN TABLE constanttable (
    test character varying,
    test2 character varying
) server multicorn_imap;


select * from constanttable  where test = 'test 0';