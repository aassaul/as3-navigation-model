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
public final class NavigationModel extends EventDispatcher {

	private var _states:Vector.<StateVO>;
	private var _currentState:StateVO;

	[Bindable(event="currentStateChange")]
	public function get currentState():StateVO{
		return _currentState;
	}

	public function set currentState(value:StateVO):void{
		var oldValue:StateVO = currentState;
		_currentState = value;
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

	public function changeState(state:StateVO):void{
		for (var i:int = 0; i < _states.length; i++) {
			var stateVO:StateVO = _states[i];
			if(stateVO.equals(state)){
				if(!stateVO.subStates){
					stateVO.subStates = new <StateVO>[state];
					state.subStates = state.getSubStatesFromSource(stateVO);
				} else if(stateVO.subStates.indexOf(state) == -1){
					stateVO.subStates.push(state);
					state.subStates = state.getSubStatesFromSource(stateVO);
				}
				_states[i] = state;
				break;
			}
		}
	}

	public function NavigationModel(states:Vector.<StateVO>) {
		super(this);
		_states = states;
		for each (var stateVO:StateVO in states) {
			stateVO.model = this;
			for each (var subState:StateVO in stateVO.subStates) {
				subState.model = this;
			}
		}
	}

	public function activate(startState:StateVO = null):void {
		startState ||= _states[0];
		Commands.run(startState.event);
	}
}
}
