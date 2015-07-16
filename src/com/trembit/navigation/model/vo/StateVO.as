/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 15.07.2015
 * Time: 17:49
 */
package com.trembit.navigation.model.vo {
import com.trembit.as3commands.events.CommandEvent;
import com.trembit.navigation.events.NavigationCommandEvent;
import com.trembit.navigation.model.NavigationModel;
import com.trembit.reflections.vo.BaseVO;

public class StateVO extends BaseVO {
	[Transient]
	public var stateType:String;
	[Transient]
	[RemoteProperty(initializer="getPreviousStateFromSource")]
	public var previousState:StateVO;
	[Transient]
	[RemoteProperty(initializer="getSubStatesFromSource")]
	public var subStates:Vector.<StateVO>;
	[Ignored]
	public var event:CommandEvent;
	[Ignored]
	public var model:NavigationModel;

	public function StateVO(stateType:String = null, prepareCommand:Class = null, subStates:Vector.<StateVO> = null,
							previousState:StateVO = null, completeEvent:CommandEvent = null, faultEvent:CommandEvent = null) {
		this.stateType = stateType;
		this.previousState = previousState;
		this.subStates = subStates;
		for each (var stateVO:StateVO in subStates) {
			stateVO.synchronizeWith(this);
		}
		event = new NavigationCommandEvent(this, prepareCommand, completeEvent, faultEvent);
	}

	public final function isPreviousForState(state:StateVO):Boolean{
		while(state.previousState){
			if(state.previousState.equals(this)){
				return true;
			}
			state = state.previousState;
		}
		return false;
	}

	public final function getPreviousStateFromSource(source:*):StateVO{
		if(source == this){
			return this.previousState;
		}
		var state:StateVO = source as StateVO;
		return state?state.previousState:null;
	}

	public final function getSubStatesFromSource(source:*):Vector.<StateVO>{
		var state:StateVO = source as StateVO;
		if(!state){
			return null;
		}
		var res:Vector.<StateVO> = new <StateVO>[state];
		for each (var stateVO:StateVO in state.subStates) {
			if(stateVO != this){
				res.push(stateVO);
			}
		}
		return res;
	}

	override public function equals(value:*):Boolean {
		if(!value){
			return false;
		}
		if(value is String){
			return (stateType == value);
		}
		if(value is StateVO){
			return (stateType == value.stateType);
		}
		return false;
	}
}
}
