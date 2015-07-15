/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 15.07.2015
 * Time: 18:37
 */
package com.trembit.navigation.model {
import com.trembit.navigation.model.vo.*;

import com.trembit.as3commands.util.Commands;
import com.trembit.navigation.events.NavigationModelEvent;

import flash.events.EventDispatcher;

[Event(name="currentStateChange", type="com.trembit.navigation.events.NavigationModelEvent")]
public class NavigationModel extends EventDispatcher {

	private var _states:Vector.<StateVO>;
	private var _currentState:StateVO;

	[Bindable(event="currentStateChange")]
	public function get currentState():StateVO{
		return _currentState;
	}

	public function set currentState(value:StateVO):void{
		var oldValue:StateVO = currentState;
		_currentState = value;
		if(oldValue && !_currentState.equals(oldValue) && !_currentState.previousState && !_currentState.isPreviousForState(oldValue)){
			_currentState.previousState = oldValue;
		}
		dispatchEvent(new NavigationModelEvent(NavigationModelEvent.CURRENT_STATE_CHANGE, oldValue, currentState));
	}

	public function getStateByType(stateType:String):StateVO {
		for each (var stateVO:StateVO in _states) {
			if(stateVO.equals(stateType)){
				return stateVO;
			}
		}
		return null;
	}

	public function NavigationModel(states:Vector.<StateVO>, startState:StateVO = null) {
		super(this);
		_states = states;
		for each (var stateVO:StateVO in states) {
			stateVO.model = this;
		}
		startState ||= states[0];
		Commands.run(startState.event);
	}
}
}
