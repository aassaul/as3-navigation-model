/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 15.07.2015
 * Time: 22:40
 */
package com.trembit.navigation {
import com.trembit.as3commands.util.Commands;
import com.trembit.navigation.commands.CompleteCommand;
import com.trembit.navigation.commands.FaultCommand;
import com.trembit.navigation.model.NavigationModel;
import com.trembit.navigation.model.vo.StateVO;

import flexunit.framework.Assert;

public class NavigationTest {

	[Test]
	public function testNavigation():void{
		var model:NavigationModel = new NavigationModel(new <StateVO>[
			new StateVO("state1", CompleteCommand), new StateVO("state2", CompleteCommand), new StateVO("state3", FaultCommand), new StateVO("state4")]);
		Assert.assertNull(model.getStateByType(""));
		Assert.assertNotNull(model.getStateByType("state4"));
		Assert.assertNotNull(model.getStateByType("state3"));
		Assert.assertNotNull(model.getStateByType("state2"));
		Assert.assertNotNull(model.getStateByType("state1"));
		Assert.assertFalse(model.getStateByType("state1").equals(model.getStateByType("state2")));
		Assert.assertFalse(model.getStateByType("state1").equals(model.getStateByType("state3")));
		Assert.assertFalse(model.getStateByType("state1").equals(model.getStateByType("state4")));
		Assert.assertFalse(model.getStateByType("state2").equals(model.getStateByType("state3")));
		Assert.assertFalse(model.getStateByType("state2").equals(model.getStateByType("state4")));
		Assert.assertFalse(model.getStateByType("state3").equals(model.getStateByType("state4")));
		Assert.assertNotNull(model.currentState);
		Assert.assertNull(model.currentState.previousState);
		Assert.assertEquals(model.currentState, model.getStateByType("state1"));

		Commands.run(model.currentState.event);
		Assert.assertNull(model.currentState.previousState);
		Assert.assertEquals(model.currentState, model.getStateByType("state1"));

		Commands.run(model.getStateByType("state2").event);
		Assert.assertEquals(model.currentState, model.getStateByType("state2"));
		Assert.assertEquals(model.currentState.previousState, model.getStateByType("state1"));

		Commands.run(model.getStateByType("state3").event);
		Assert.assertFalse(model.currentState.equals(model.getStateByType("state3")));
		Assert.assertEquals(model.currentState, model.getStateByType("state2"));

		Commands.run(model.getStateByType("state4").event);
		Assert.assertEquals(model.currentState, model.getStateByType("state4"));
		Assert.assertEquals(model.currentState.previousState, model.getStateByType("state2"));

		Commands.run(model.getStateByType("state1").event);
		Assert.assertEquals(model.currentState, model.getStateByType("state1"));
		Assert.assertNull(model.currentState.previousState);
	}
}
}
