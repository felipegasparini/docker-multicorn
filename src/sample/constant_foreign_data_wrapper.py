try:
    # workaround to have the multicornapi only for development
    from multicornapi import ForeignDataWrapper
except:
    import importlib

    multicorn = importlib.import_module("multicorn")
    ForeignDataWrapper = multicorn.ForeignDataWrapper


class ConstantForeignDataWrapper(ForeignDataWrapper):
    """
        Simple example based from: https://multicorn.org/implementing-a-fdw/
    """

    def __init__(self, fdw_options, fdw_columns):
        self.fdw_options = fdw_options
        self.fdw_columns = fdw_columns

    def execute(self, quals, columns, sortkeys=None):
        for index in range(20):
            line = {}
            for column_name in self.fdw_columns:
                line[column_name] = '%s %s' % (column_name, index)
            yield line
