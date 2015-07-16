/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 16.07.2015
 * Time: 2:39
 */
package com.trembit.navigation.model.vo {
import com.trembit.as3commands.events.CommandEvent;

public class TestVO extends StateVO {

	public var testProp:String;

	public function TestVO(stateType:String = null, prepareCommand:Class = null, subStates:Vector.<StateVO> = null,
						   previousState:StateVO = null, completeEvent:CommandEvent = null, faultEvent:CommandEvent = null) {
		super(stateType, prepareCommand, subStates, previousState, completeEvent, faultEvent);
	}
}
}
