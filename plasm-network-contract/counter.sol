pragma solidity 0;

contract counter {
	uint32 private value;

	/// Constructor that initializes the `int32` value to the given `init_value`.
	constructor(uint32 initvalue) {
		value = initvalue;
	}

	/// This increments the value by `by`. 
	function incr(uint32 by) public {
		value += by;
	}

	/// This decrements the value by `by`, but only if value is above 0.
	function decr(uint32 by) public {
		if (value > 0) {
			value -= by;
		}
	}

	/// Simply returns the current value of our `uint32`.
	function get() public view returns (uint32) {
		return value;
	}
}